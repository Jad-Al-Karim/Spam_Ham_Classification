df <- read.delim("SMSSpamCollection", header = FALSE, stringsAsFactors = FALSE, sep = "\t", quote = "")
colnames(df) <- c("type", "message")

# add a short example ham row (keeps original intent)
s <- data.frame(type = "ham",
				message = "Go.until.jurong.point..crazy...Available.only.in.bugis.n.great.world.la.e.buffet....Cine.there.got.amore.wat...",
				stringsAsFactors = FALSE)
df <- rbind(df, s)

write.csv(df, "C:/Users/NTC/Downloads/spam_ham.csv", row.names = FALSE)

# Prepare Enron/spam combination (assumes `spam` and `Enron_Txt_fn` exist in environment)
colnames(spam) <- c("type", "message")
spam <- spam[, -c(3, 4, 5)]

df_spam <- Enron_Txt_fn
df_spam_only <- df_spam[df_spam$type == "spam", ]
set.seed(123)
df_spam_subset <- df_spam_only[sample(nrow(df_spam_only), 4078), ]

df_combined <- rbind(spam, df_spam_subset)
print(table(df_combined$type))

write.csv(df_combined, "C:/Users/NTC/Downloads/df_combined1.csv", row.names = FALSE)
df_combined$message <- iconv(df_combined$message, from = "", to = "UTF-8", sub = "byte")
write.csv(df_combined, "C:/Users/NTC/Downloads/combined.csv", row.names = FALSE, fileEncoding = "UTF-8")
