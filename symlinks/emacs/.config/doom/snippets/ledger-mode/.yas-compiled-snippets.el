;;; Compiled snippets and support files for `ledger-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'ledger-mode
                     '(("t" "${1:`(format-time-string \"%Y\")`}-${2:`(format-time-string \"%m\")`}-${3:`(format-time-string \"%d\")`} ${4:Name}\n    ${5:Account}  \\$${6:0.00}\n    ${7:Fund}\n" "Transaction" nil nil
                        ((yas-indent-line 'fixed))
                        "/Users/mks/.config/doom/snippets/ledger-mode/transaction" nil nil)
                       ("p" "${1:`(format-time-string \"%Y\")`}-${2:`(format-time-string \"%m\")`}-${3:`(format-time-string \"%d\")`} ${4:Name}\n    Liabilities:$5  \\$${6:0.00}\n    Assets:$7\n" "Payment" nil nil
                        ((yas-indent-line 'fixed))
                        "/Users/mks/.config/doom/snippets/ledger-mode/payment" nil nil)
                       ("i" "${1:`(format-time-string \"%Y\")`}-${2:`(format-time-string \"%m\")`}-${3:`(format-time-string \"%d\")`} ${4:Name}\n    Assets:$5  \\$${6:0.00}\n    Income:$7\n" "Income" nil nil
                        ((yas-indent-line 'fixed))
                        "/Users/mks/.config/doom/snippets/ledger-mode/income" nil nil)
                       ("e" "${1:`(format-time-string \"%Y\")`}-${2:`(format-time-string \"%m\")`}-${3:`(format-time-string \"%d\")`} ${4:Name}\n    Expenses:$5  \\$${6:0.00}\n    Assets:$7\n" "Expense" nil nil
                        ((yas-indent-line 'fixed))
                        "/Users/mks/.config/doom/snippets/ledger-mode/expense" nil nil)))


;;; Do not edit! File generated at Sat Mar  7 10:21:01 2020
