;; package源相关设置
;; 添加新的软件源
(when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
		      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

;; cl - Common Lisp Extension
(require 'cl)

;; 做一个想要的package的列表, 启动emacs时,如果没有此package, 则会自动下载
;; Add Packages
(defvar cxy/packages '(
		company	;; 号称能够补全任何东西的插件
		monokai-theme    ;; 一个黑色的主题
		hungry-delete	;; 能够一次性删除多个空格的插件
		expand-region	;; 自动选择光标所在区域的插件
		pyim			;; emacs内置拼音输入法
		pyim-basedict	;; pyim的拼音字典
		elpy			;; emacs的python开发环境
		irony			;; C/C++ minor mode
		smart-tabs-mode
		) "Default packages")

(defun cxy/packages-installed-p ()
     (loop for pkg in cxy/packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))

(unless (cxy/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg cxy/packages)
       (when (not (package-installed-p pkg))
	 (package-install pkg))))

;; smart-tab-mode
;;(setq-default indent-tabs-mode nil)
;;(setq-default tab-width 4)
;;(smart-tabs-insinuate 'c 'c++)
;;(add-hook 'c-mode-common-hook
;;              (lambda () (setq indent-tabs-mode t)))
;;(add-hook 'c++-mode-common-hook
;;              (lambda () (setq indent-tabs-mode t)))
;;(smart-tabs-add-language-support c++ c++-mode-hook
;;      ((c-indent-line . c-basic-offset)
;;       (c-indent-region . c-basic-offset)))



;; irony 配置（增强C＋＋）功能
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;elpy配置
(elpy-enable)

;; 输入法配置
(require 'pyim)
(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
(setq default-input-method "pyim")
(setq-default pyim-punctuation-translate-p '(no yes auto))   ;使用半角标点
;; 上面的配置貌似不管用, 直接在启动时进行一次全角半角的切换
;;(pyim-punctuation-toggle)

;; 默认打开company
;;(global-company-mode 1)
(add-hook 'after-init-hook 'global-company-mode)

;; 启用monokai主题
(load-theme 'monokai t)

;; 启用hungry-delete-mode
;;(require 'hungry-delete)
;;(global-hungry-delete-mode)


;; 加载CEDET和ecb的配置, 这两个package并不是从elpa下载的, 而是手动编译安装的
;; Load CEDET
;;(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")
(require 'cedet)
;;(semantic-load-enable-code-helpers)

(custom-set-variables
 '(semantic-default-submodes (quote (global-semantic-decoration-mode global-semantic-idle-completions-mode
                                     global-semantic-idle-scheduler-mode global-semanticdb-minor-mode)))
 '(semantic-idle-scheduler-idle-time 3))

(semantic-mode)

(require 'semantic/analyze)
(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)

;; ECB config
(add-to-list 'load-path "~/.emacs.d/ecb-2.40")
(require 'ecb)

(setq stack-trace-on-error t)

;;不显示ecb每日提示
(setq ecb-tip-of-the-day nil)

;; 设置semantic cache临时文件的路径，避免到处都是临时文件
(setq semanticdb-default-save-directory "/work/semanticdb")

(provide 'init-packages)
