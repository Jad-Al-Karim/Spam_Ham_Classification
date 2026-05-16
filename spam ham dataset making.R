## Preprocessing script for combining spam/ham datasets
## Requires: R >= 4.0 (for best compatibility)

## Read SMSSpamCollection (tab-delimited)
if (!file.exists("SMSSpamCollection")) {
	stop("SMSSpamCollection not found in working directory; place the file here or update the script paths.")
}
df <- read.delim("SMSSpamCollection", header = FALSE, stringsAsFactors = FALSE, sep = "\t", quote = "")
colnames(df) <- c("type", "message")

## Add a short example ham row (keeps original intent)
s <- data.frame(
	type = "ham",
	message = "Go.until.jurong.point..crazy...Available.only.in.bugis.n.great.world.la.e.buffet....Cine.there.got.amore.wat...",
	stringsAsFactors = FALSE
)
df <- rbind(df, s)

## Write a local copy of spam_ham.csv
write.csv(df, "C:/Users/NTC/Downloads/spam_ham.csv", row.names = FALSE)

## Read `spam_ham.csv` and `Enron_Txt_fn.csv` if present so script can run standalone
if (file.exists("spam_ham.csv")) {
	spam <- read.csv("spam_ham.csv", stringsAsFactors = FALSE)
} else if (exists("spam")) {
	# use existing `spam` object in environment
} else {
	stop("spam_ham.csv not found and `spam` object not present. Provide spam_ham.csv or load `spam` before running.")
}

if (file.exists("Enron_Txt_fn.csv")) {
	Enron_Txt_fn <- read.csv("Enron_Txt_fn.csv", stringsAsFactors = FALSE)
} else if (!exists("Enron_Txt_fn")) {
	warning("Enron_Txt_fn.csv not found; Enron sampling will be skipped.")
}

## Normalize `spam` columns and drop extraneous columns if they exist
if (all(c("type", "message") %in% colnames(spam))) {
	# keep only first two columns if there are extra empty columns
	spam <- spam[, c("type", "message")]
} else {
	# try to rename common column names
	nc <- tolower(colnames(spam))
	if ("v1" %in% nc && "v2" %in% nc) {
		colnames(spam)[which(nc == "v1")[1]] <- "type"
		colnames(spam)[which(nc == "v2")[1]] <- "message"
		spam <- spam[, c("type", "message")]
	} else {
		stop("`spam` does not contain expected columns 'type' and 'message'.")
	}
}

## If Enron data is available, sample spam rows and combine
df_combined <- NULL
if (exists("Enron_Txt_fn") && "type" %in% colnames(Enron_Txt_fn)) {
	df_spam_only <- Enron_Txt_fn[Enron_Txt_fn$type == "spam", ]
	set.seed(123)
	target_n <- min(4078, nrow(df_spam_only))
	if (target_n > 0) df_spam_subset <- df_spam_only[sample(nrow(df_spam_only), target_n), ] else df_spam_subset <- df_spam_only
	df_combined <- rbind(spam, df_spam_subset)
} else {
	df_combined <- spam
}

print(table(df_combined$type))

write.csv(df_combined, "C:/Users/NTC/Downloads/df_combined1.csv", row.names = FALSE)
df_combined$message <- iconv(df_combined$message, from = "", to = "UTF-8", sub = "byte")
write.csv(df_combined, "C:/Users/NTC/Downloads/combined.csv", row.names = FALSE, fileEncoding = "UTF-8")
