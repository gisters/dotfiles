;;; init-css.el --- CSS/Less/SASS/SCSS support -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; Colourise CSS colour literals
(when (maybe-require-package 'rainbow-mode)
  (dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
    (add-hook hook 'rainbow-mode)))


;;; SASS and SCSS
(require-package 'sass-mode)
(unless (fboundp 'scss-mode)
  (require-package 'scss-mode))
(setq-default scss-compile-at-save nil)


;;; LESS
(unless (fboundp 'less-css-mode)
  (require-package 'less-css-mode))
(when (maybe-require-package 'skewer-less)
  (add-hook 'less-css-mode-hook 'skewer-less-mode))


;; Skewer CSS
(when (maybe-require-package 'skewer-mode)
  (add-hook 'css-mode-hook 'skewer-css-mode))


;;; Use eldoc for syntax hints
(require-package 'css-eldoc)
(autoload 'turn-on-css-eldoc "css-eldoc")
(add-hook 'css-mode-hook 'turn-on-css-eldoc)

(provide 'init-css)
;;; init-css.el ends here
