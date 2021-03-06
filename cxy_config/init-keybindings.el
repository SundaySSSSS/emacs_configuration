;;放弃使用ecb
;;(global-set-key (kbd "<f7>") 'ecb-minor-mode)   ; 打开ecb
;;;;ecb 窗口间切换的快捷键快捷键
;;(global-set-key (kbd "C-<left>") 'windmove-left)   ;左边窗口
;;(global-set-key (kbd "C-<right>") 'windmove-right)  ;右边窗口
;;(global-set-key (kbd "C-<up>") 'windmove-up)     ; 上边窗口
;;(global-set-key (kbd "C-<down>") 'windmove-down)   ; 下边窗口

;; 使用快捷键打开此文件
;;(global-set-key (kbd "C-<f2>" 'open-my-init-file)
(global-set-key (kbd "C-<f2>") 'open-my-init-file)

;; expand-region快捷键
(global-set-key (kbd "C-=") 'er/expand-region)

;; 拼音输入法切换
(global-set-key (kbd "C-c c p") 'toggle-input-method)

;;semantic设置
;;(global-set-key (kbd "<f12>") 'semantic-ia-fast-jump)   ;跳转
;;(global-set-key (kbd "C-<f12>") 'semantic-mrub-switch-tags)   ;跳转回去

;; 搜索相关配置
(global-set-key (kbd "C-c a g") 'helm-do-ag-project-root) ;; Call helm-ag at project root. helm-ag seems directory as project root where there is .git or .hg or .svn.

;; 将C-s绑定为保存buffer, 和其他编辑器保持一致
(global-set-key (kbd "C-s") 'save-buffer)

;; 交换跳转到行首和第一个字符前的按键绑定
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "M-m") 'move-beginning-of-line)

;; 设置C-z为撤销
(global-set-key (kbd "C-z") 'undo)

;; 使用ag搜索当前标志符
(global-set-key (kbd "C-c f") 'search-ag-with-current-identifier)

;; 打开ansi-term终端
(global-set-key (kbd "C-c t") 'ansi-term)

;; 进入occur进行单文件搜索
(global-set-key (kbd "C-c o") 'occur-dwim)

(provide 'init-keybindings)
