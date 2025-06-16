global class CreateAccountsBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // Возвращаем пустой QueryLocator, чтобы начать выполнение
        return Database.getQueryLocator([SELECT Id FROM Account WHERE Id = null LIMIT 1]);
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        List<Account> newAccounts = new List<Account>();

        // Создание новых аккаунтов
        for (Integer i = 0; i < 20; i++) {
            Account newAccount = new Account();
            newAccount.Name = 'Account ' + (i + 1); // Пример заполнения имени аккаунта
            newAccounts.add(newAccount);
        }

        // Выполнение DML операции для создания аккаунтов
        if (!newAccounts.isEmpty()) {
            insert newAccounts;
        }
    }

    global void finish(Database.BatchableContext BC) {
        // Код, выполняемый после завершения обработки всех партий
        System.debug('Аккаунты успешно созданы.');
    }
}