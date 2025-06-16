global class ErrorHandlingBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // Возвращаем пустой QueryLocator, чтобы начать выполнение
        return Database.getQueryLocator([SELECT Id FROM Account LIMIT 1]);
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        try {
            // Пример деления на ноль
            Integer i = 2 / 0;
        } catch (Exception e) {
            for (Integer j = 0; j < 10001; j++) {
                // Добавление ошибки в систему
                Triton.instance.addError(TritonTypes.Area.Accounts, e);
            }
            // Обработка всех накопленных ошибок
            Triton.instance.flush();
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Обработка ошибок завершена.');
    }
}