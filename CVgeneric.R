CVgeneric <- function(classifier, features, labels, K, loss_func) {
  # Setting the k folds
  # features is a list of dataframes, labels is a list of label columns
  folds = sample(cut(seq(1, length(features)), breaks=K, labels=FALSE))
  loss_list = list()
  
  for(i in 1:K) {
    test_indices = which(folds==i, arr.ind=TRUE)
    train_data = do.call('rbind', trainVal_data_log[-test_indices])
    test_data = do.call('rbind', trainVal_data_log[test_indices])
    test_labels = do.call('rbind', labels[test_indices])
    
    model = train(label ~ ., data = train_data, method = classifier, family = 'binomial')
    predicted = predict(model, test_data, type='response')
    loss = loss_func(train_labels, predicted)
    
    loss_list[i] = loss
  }
  
  mean(loss_list)
}