library(MASS)

data <- read.csv("data/repa_data_20231022.csv")

# print(summary(data))

new_data <- data[data$published_time != 0, ]
new_data$is_retracted <- as.factor(new_data$is_retracted)

# print(summary(new_data))

new_data$st_published_time <- scale(new_data$published_time)
new_data$st_total_comment <- scale(new_data$total_comment)
new_data$st_author_active <- scale(new_data$author_active)
new_data$st_comment_len <- scale(new_data$comment_len)
new_data$st_reword <- scale(new_data$reword)
new_data$st_my_prediction_NEU <- scale(new_data$my_prediction_NEU)
new_data$st_my_prediction_POS <- scale(new_data$my_prediction_POS)
new_data$st_my_prediction_NEG <- scale(new_data$my_prediction_NEG)

# print(summary(new_data))

re_data <- new_data[new_data$is_retracted == "Yes", ]
nre_data <- new_data[new_data$is_retracted == "No", ]

# print(nrow(nre_data))

set.seed(622)

nre_idx <- sample(nrow(nre_data), 1000)
re_idx <- sample(nrow(re_data), 1000)

train_data <- rbind(nre_data[nre_idx, ], re_data[re_idx, ])

# print(nrow((train_data)))

# glm_repa <- glm(
#     is_retracted ~ published_time +
#         total_comment + author_active + comment_len +
#         reword + my_prediction_NEU + my_prediction_POS +
#         my_prediction_NEG + st_published_time +
#         st_total_comment + st_author_active +
#         st_comment_len + st_reword + st_my_prediction_NEU +
#         st_my_prediction_POS + st_my_prediction_NEG +
#         I(published_time^2) + I(total_comment^2) +
#         I(author_active^2) + I(comment_len^2) +
#         I(reword^2) + I(my_prediction_NEU^2) + I(my_prediction_NEG^2) +
#         I(my_prediction_POS^2) + sqrt(published_time) +
#         sqrt(total_comment) + sqrt(author_active) +
#         sqrt(comment_len) + sqrt(reword) +
#         sqrt(my_prediction_NEU) + sqrt(my_prediction_NEG) +
#         sqrt(my_prediction_POS) + log(published_time),
#     data = train_data, family = "binomial"
# )

glm_repa <- glm(
    is_retracted ~ st_published_time +
        st_total_comment +
        st_comment_len +
        I(st_published_time^2) + I(st_total_comment^2) +
        I(comment_len^2) +
        I(reword^2) +
        sqrt(published_time) +
        sqrt(total_comment) +
        sqrt(comment_len),
    data = train_data, family = "binomial"
)

# repa_data_20231109 <- data.frame(
#     is_retracted = new_data$is_retracted,
#     published_time = new_data$st_published_time,
#     total_comment = new_data$st_total_comment,
#     author_active = new_data$st_author_active,
#     comment_len = new_data$st_comment_len,
#     reword = new_data$st_reword,
#     squ_published_time = (new_data$published_time)^2,
#     squ_total_comment = (new_data$total_comment)^2,
#     squ_author_active = (new_data$author_active)^2,
#     squ_comment_len = (new_data$comment_len)^2,
#     squ_reword = (new_data$reword)^2,
#     sqrt_published_time = sqrt(new_data$published_time),
#     sqrt_total_comment = sqrt(new_data$total_comment),
#     sqrt_author_active = sqrt(new_data$author_active),
#     sqrt_comment_len = sqrt(new_data$comment_len),
#     sqrt_reword = sqrt(new_data$reword)
# )

# write.table(repa_data_20231109,
#     file = "data/repa_data_20231109.csv", sep = ",",
#     col.names = TRUE, row.names = FALSE
# )

print(summary(glm_repa))

nre_data <- nre_data[-nre_idx, ]
re_data <- re_data[-re_idx, ]
nre_test_idx <- sample(nrow(nre_data), 1000)
re_test_idx <- sample(nrow(re_data), 1000)

test_data <- rbind(nre_data[nre_test_idx, ], re_data[re_test_idx, ])

repa_predict <- predict(glm_repa, newdata = test_data, type = "response")

predictions <- ifelse(repa_predict > 0.4, "Yes", "No")
print(table(real = test_data$is_retracted, predict = predictions))

roc <- data.frame(pro = repa_predict, class = test_data$is_retracted)

write.table(roc,
    file = "data/roc.csv", sep = ",",
    col.names = TRUE, row.names = FALSE
)
