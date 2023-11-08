library(MASS)

data <- read.csv("data/repa_data_20231022.csv")

# print(summary(data))

new_data <- data[data$published_time != 0, ]
new_data$is_retracted <- as.factor(new_data$is_retracted)

print(summary(new_data))

re_data <- new_data[new_data$is_retracted == "Yes", ]
nre_data <- new_data[new_data$is_retracted == "No", ]

# print(nrow(nre_data))

set.seed(622)

nre_idx <- sample(nrow(nre_data), 1000)
re_idx <- sample(nrow(re_data), 1000)

train_data <- rbind(nre_data[nre_idx, ], re_data[re_idx, ])

print(nrow((train_data)))

glm_repa <- glm(is_retracted ~ published_time +
    total_comment + author_active + comment_len +
    reword + my_prediction_NEU + my_prediction_POS +
    my_prediction_NEG, data = train_data, family = "binomial")

print(summary(glm_repa))

glm_repa <- glm(is_retracted ~ published_time +
    total_comment + author_active + comment_len +
    reword, data = train_data, family = "binomial")

print(summary(glm_repa))

nre_data <- nre_data[-nre_idx, ]
re_data <- re_data[-re_idx, ]
nre_test_idx <- sample(nrow(nre_data), 1000)
re_test_idx <- sample(nrow(re_data), 1000)

test_data <- rbind(nre_data[nre_test_idx, ], re_data[re_test_idx, ])

repa_predict <- predict(glm_repa, newdata = test_data, type = "response")

predictions <- ifelse(repa_predict > 0.15, "Yes", "No")
print(table(real = test_data$is_retracted, predict = predictions))

roc <- data.frame(pro = repa_predict, class = test_data$is_retracted)

write.table(roc,
    file = "data/roc.csv", sep = ",",
    col.names = TRUE, row.names = FALSE
)
