(global-set-key (kbd "<f7>") 'ecb-minor-mode)   ; 打开ecb
;;;;ecb 窗口间切换的快捷键快捷键
(global-set-key (kbd "C-<left>") 'windmove-left)   ;左边窗口
(global-set-key (kbd "C-<right>") 'windmove-right)  ;右边窗口
(global-set-key (kbd "C-<up>") 'windmove-up)     ; 上边窗口
(global-set-key (kbd "C-<down>") 'windmove-down)   ; 下边窗口

;; 使用快捷键打开此文件
;;(global-set-key (kbd "C-<f2>" 'open-my-init-file)
(global-set-key (kbd "C-<f2>") 'open-my-init-file)

;; expand-region快捷键
(global-set-key (kbd "C-=") 'er/expand-region)

;; 拼音输入法切换
(global-set-key (kbd "C-c c p") 'toggle-input-method)

;;semantic设置
(global-set-key (kbd "<f12>") 'semantic-ia-fast-jump)   ;跳转
(global-set-key (kbd "C-<f12>") 'semantic-mrub-switch-tags)   ;跳转回去

(provide 'init-keybindings)
