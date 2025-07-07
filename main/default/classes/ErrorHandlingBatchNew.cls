global class ErrorHandlingBatchNew implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id FROM Account LIMIT 1]);
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        for (Integer k = 0; k < 1; k++) {
            executeLogic();
        }
    }

    private void executeLogic() {
        try {
            // Генерация случайного числа от 0 до 1
            Double randomValue = Math.random();
            
            // Условие для выброса ошибки с 50% вероятностью
            if (randomValue < 1) {
                Integer i = 2 / 0; // Искусственное деление на ноль
            }
        } catch (Exception e) {
            // Генерация случайного количества добавляемых ошибок от 1 до 3
            Integer errorCount = (Integer)(Math.random() * 3) + 1; 
            Integer jobsQueued = 0; // Счетчик добавленных задач

            for (Integer j = 0; j < errorCount; j++) {
                // Проверяем, добавлено ли менее 50 задач
                if (jobsQueued < 50) { 
                    // Генерация случайного типа ошибки
                    if (Math.random() < 1) {
                        // Добавляем основную ошибку в новую транзакцию
                        System.enqueueJob(new ErrorQueueable(e));
                    } else {
                        // Добавляем пользовательскую случайную ошибку в новую транзакцию
                        System.enqueueJob(new ErrorQueueable(new CustomException('Случайная ошибка ' + j)));
                    }
                    jobsQueued++; // Увеличиваем счетчик добавленных задач
                } else {
                    break; // Если достигнуто ограничение, выходим из цикла
                }
            }
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Test');
    }
}