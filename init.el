(package-initialize)

(add-to-list 'load-path "~/.emacs.d/cxy_config/")

;; 打开本文件的函数
(defun open-my-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(require 'init-packages)
(require 'init-ui)
(require 'init-better-defaults)
(require 'init-org)
(require 'init-custom)
(require 'init-keybindings)
