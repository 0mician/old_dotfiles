;;; Email Client configuration
(require 'mu4e)

(setq mu4e-maildir "~/Maildir/GmailCL")
(setq mu4e-drafts-folder "/drafts")
(setq mu4e-sent-folder   "/sent")
(setq mu4e-trash-folder  "/trash")
(setq mu4e-sent-messages-behavior 'delete) ;; no need to save, gmail does it

(setq mu4e-maildir-shortcuts
      '( ("/inbox" . ?i)
         ("/sent" . ?s)
         ("/trash" . ?t)
         ("/archive" . ?a)))

(setq mu4e-get-mail-command "offlineimap"
      mu4e-update-interval 300)

(setq mu4e-view-show-images t)
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))
(setq mu4e-view-prefer-html t)
(setq mu4e-html2text-command "html2text -utf8 -width 72")

(setq
 user-mail-address "cedric.lood@gmail.com"
 user-full-name "Cedric Lood")

(setq mail-user-agent 'mu4e-user-agent)

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
    smtpmail-stream-type 'starttls
    smtpmail-default-smtp-server "smtp.gmail.com"
    smtpmail-smtp-server "smtp.gmail.com"
    smtpmail-smtp-service 587)

(setq message-kill-buffer-on-exit t)

