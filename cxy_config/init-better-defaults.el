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

(provide 'init-better-defaults)
