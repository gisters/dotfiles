;;; init-erc.el --- erc auth -*- lexical-binding: t -*-
;;; Commentary:
;;; /nick yourname
;;; /msg nickserv register your-password your-email
;;; Then, you will recive an email, follow the email to verify register
;;; Code:


(custom-set-variables
 '(erc-autojoin-timing 'ident)
 '(erc-autojoin-delay 10))

(require 'erc-track)
(erc-track-mode t) ; was (erc-track-modified-channels-mode t)
                   ; Note: erc-track-modified-channels-mode changed
                   ; to erc-track-mode as of erc-track.el
                   ; CVS revision 1.23 (November 2002)

(add-hook 'erc-mode-hook
          '(lambda ()
             (require 'erc-pcomplete)
             (pcomplete-erc-setup)
             (erc-completion-mode 1)))

;; http://www.emacswiki.org/emacs/ErcAutoQuery
(setq erc-auto-query 'buffer)
(add-hook 'erc-after-connect
          (lambda (server nick)
            (add-hook 'erc-server-NOTICE-hook 'erc-auto-query)))

;; Ignoring notices
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(setq erc-echo-notices-in-minibuffer-flag t)
(require 'erc-fill)
(erc-fill-mode t)
(require 'erc-ring)
(erc-ring-mode t)
(setq whitespace-global-modes '(not erc-mode))
;; Don't flood bufer with quit/joins when a netsplit happens
(require 'erc-netsplit)
(erc-netsplit-mode t)
(erc-timestamp-mode t)
(setq erc-timestamp-format "[%R-%m/%d]")
(erc-button-mode nil) ;slow

;; logging:
(setq erc-log-insert-log-on-open nil)
(setq erc-log-channels t)
(setq erc-log-channels-directory "~/.irclogs/")
(setq erc-save-buffer-on-part t)
(setq erc-hide-timestamps nil)

(defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
           (save-some-buffers t (lambda ()
                                  (when (and (eq major-mode 'erc-mode)
                                             (not (null buffer-file-name)))))))

(add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)
(add-hook 'erc-mode-hook
          '(lambda ()
             (when (not (featurep 'xemacs))
               (set (make-variable-buffer-local
                      'coding-system-for-write)
                    'emacs-mule))))
;; end logging

;; Truncate buffers so they don't hog core.
(setq erc-max-buffer-size 20000)
(defvar erc-insert-post-hook)
(add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
(setq erc-truncate-buffer-on-save t)

;; Clears out annoying erc-track-mode stuff for when we don't care.
;; Useful for when ChanServ restarts :P
(defun reset-erc-track-mode ()
  "Clears out."
  (interactive)
  (setq erc-modified-channels-alist nil)
  (erc-modified-channels-update))
(global-set-key (kbd "C-c r") 'reset-erc-track-mode)

;;
(require 'erc-match)
(setq erc-keywords '("Bardon"))
(erc-match-mode)

;; Autojoin when we start-up
(require 'erc-join)
(erc-autojoin-mode 1)
(setq erc-autojoin-channels-alist
      '(("freenode.net" "#gentoo-cn" "#archlinux-cn" "#ubuntu-cn"
         "#debian-cn")
;        ("oftc.net" "#arch-cn")
        ))

;; Finally, connect to the networks.
(defun ierc ()
  "Connect to IRC."
  (interactive)
  (let
    ((password-cache nil))
    (erc-tls
      :server "chat.freenode.net"
      :port 6697
      :nick "Bardon"
      :full-name "Bardon"
      :password (password-read (format "Your password for freenode? ")))
;    (erc-tls
;      :server "irc.oftc.net"
;      :port 6697
;      :nick "bardon"
;      :full-name "Bardon"
;      :password (password-read (format "Your password for oftc?")))
    ))

(provide 'init-erc)
;;; init-erc.el ends here
