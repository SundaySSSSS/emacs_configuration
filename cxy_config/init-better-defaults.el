;; 设置emacs字体
(when (eq system-type 'windows-nt)
  ;; 在Windows下设置为Consolas字体
  (set-default-font "-outline-Consolas-normal-normal-normal-mono-15-*-*-*-c-*-iso8859-1")
)

;; 禁止emacs备份文件
(setq make-backup-files nil)
(setq auto-save-default nil)

;; 打开最近文件, 可以通过快捷键打开最近打开文件列表
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; 开启括号匹配高亮(在写lisp代码时很方便查看括号匹配情况)
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; 自动加载外部修改过的文件
(global-auto-revert-mode 1)

;; 关闭自动保存文件
(setq auto-save-default nil)

;; 关闭错误提示音
(setq ring-bell-function 'ignore)

;;以下设置缩进  
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq c-default-style "linux")
(setq c-basic-offset 4)

;; 高亮显示当前行
;;(global-hl-line-mode 1)

;; 设置垃圾回收，在Windows下，emacs25版本会频繁出发垃圾回收，所以需要设置
(when (eq system-type 'windows-nt)	;; windows上的设置
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect)
  ;; 显示垃圾回收信息，这个可以作为调试用
  ;; (setq garbage-collection-messages t)
  ;;中文与外文字体设置, 保证中英文等宽等高目前只有使用文泉驿等宽正黑
  ;;(set-default-font "文泉驿等宽正黑:pixelsize=18:foundry=unknown:weight=medium:slant=normal:width=normal:scalable=true")
  )

(when (eq system-type 'darwin)	;; mac上的设置
  (setq command-line-default-directory "~/")	;; mac上默认为home目录
  (set-default-font "Menlo:pixelsize=18:foundry=unknown:weight=medium:slant=normal:width=normal:scalable=true")
  (setq python-shell-interpreter "/usr/bin/python")
  )

(when (eq system-type 'gnu/linux)	;; linux设置
  ;;中文与外文字体设置, 保证中英文等宽等高目前只有使用文泉驿等宽正黑
  (set-default-font "文泉驿等宽正黑:pixelsize=18:foundry=unknown:weight=medium:slant=normal:width=normal:scalable=true")
  ;; 设置默认工作目录(emacs启动后所在的目录)
  (setq command-line-default-directory "/work/share/")
)

;; 加大行间距, 否则使用文泉驿等宽字体体验不佳
(setq-default line-spacing 5)

;;给eshell上色, 借用了codenew的配置
;;将eshell的prompt设定成和bash一样 
(setq eshell-prompt-function
      '(lambda ()
         (concat
          user-login-name "@" system-name " "
          (if (search (directory-file-name (expand-file-name (getenv "HOME"))) (eshell/pwd))
              (replace-regexp-in-string (expand-file-name (getenv "HOME")) "~" (eshell/pwd))
            (eshell/pwd))
          (if (= (user-uid) 0) " # " " $ "))))
;;替eshell的prompt上色
(defun colorfy-eshell-prompt ()
  "Colorfy eshell prompt according to `user@hostname' regexp."
  (let* ((mpoint)
         (user-string-regexp (concat "^" user-login-name "@" system-name)))
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward (concat user-string-regexp ".*[$#]") (point-max) t)
        (setq mpoint (point))
        (overlay-put (make-overlay (point-at-bol) mpoint) 'face '(:foreground "dodger blue")))
      (goto-char (point-min))
      (while (re-search-forward user-string-regexp (point-max) t)
        (setq mpoint (point))
        (overlay-put (make-overlay (point-at-bol) mpoint) 'face '(:foreground "green3"))
        ))))

;; Make eshell prompt more colorful
(add-hook 'eshell-output-filter-functions 'colorfy-eshell-prompt)

;; 当选中一部分时, 输入任意字符都会替换掉选中文本
(delete-selection-mode 1)

;; 工具函数, 判定输入字符是否为特定的分隔符
(defun check-char-is-special-divider(char)
  (or (equal char "_") (equal char "-")) ;; 如果为-或_, 返回t, 否则返回nil
  )

;; 工具函数, 返回当前region前/后一个字符, 如果没有, 返回nil
(defun get-char-front-region()
  (if (= (region-beginning) (point-min))
    (progn
      (nil)
      )
    (progn
      (buffer-substring (- (region-beginning) 1) (region-beginning))
      )
    )
  )
(defun get-char-behind-region()
  (if (= (region-end) (point-max))
    (progn
      (nil)
      )
    (progn
      (buffer-substring (region-end) (+ 1 (region-end)))
      )
    )
  )

;; 使用ag搜索选中的标志符
(defun search-ag-with-current-identifier()
    "search the current identifier by ag"
    (interactive)
    ;;(message "buffer contains words."))
    ;;(message "begin at %s\nend at %s" (region-beginning) (region-end))
    (er/expand-region 1)
    (setq pre_char (get-char-front-region))
    (setq suf_char (get-char-behind-region))
    (if (or (check-char-is-special-divider pre_char) (check-char-is-special-divider suf_char))
      (progn
        (er/expand-region 1) ;; 如果检测到前一次选中的两侧有-或_, 再执行一次, 即可将整个标志符选中
        )
      )
    (helm-do-ag-project-root) ;;搜索标志符
    )

;; occur配置
(defun occur-dwim ()
  "let `occur' do what I mean."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))

(provide 'init-better-defaults)
