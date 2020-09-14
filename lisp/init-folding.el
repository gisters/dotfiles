;;; init-folding.el --- Support code and region folding -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'origami)
  (after-load 'origami
    (define-key origami-mode-map (kbd "C-c f") 'origami-toggle-node)))


(provide 'init-folding)
;;; init-folding.el ends here
