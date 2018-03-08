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
  
;;以下设置缩进  
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq c-default-style "linux")
(setq c-basic-offset 4)

;; 设置默认工作目录(emacs启动后所在的目录)
(setq command-line-default-directory "/work/share/")

;; 高亮显示当前行
;;(global-hl-line-mode 1)

;;中文与外文字体设置, 保证中英文等宽等高目前只有使用文泉驿等宽正黑
(set-default-font "文泉驿等宽正黑:pixelsize=18:foundry=unknown:weight=medium:slant=normal:width=normal:scalable=true")
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

(provide 'init-better-defaults)
