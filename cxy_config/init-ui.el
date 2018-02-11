
;;显示行号
(global-linum-mode 1) ; always show line numbers
(setq linum-format "%d") ; set format

;; 关闭丑陋的工具栏
(tool-bar-mode -1)

;; 将默认光标改为竖线
(setq-default cursor-type 'bar)

;; 开启emacs时自动最大化
(setq initial-frame-alist (quote ((fullscreen . maximized))))

(provide 'init-ui)
