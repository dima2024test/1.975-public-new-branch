global class CreateAccountsBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // Возвращает пустой список, так как мы создаем новые записи
        return null; // или можно использовать Database.getQueryLocator с пустым запросом
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        List<Account> newAccounts = new List<Account>();

        // Создание новых аккаунтов
        for (Integer i = 0; i < 2000; i++) {
            Account newAccount = new Account();
            newAccount.Name = 'Account ' + (i + 1); // Пример заполнения имени аккаунта
            // Добавьте другие необходимые поля, если нужно
            newAccounts.add(newAccount);
        }

        // Выполнение DML операции для создания аккаунтов
        insert newAccounts;
    }

    global void finish(Database.BatchableContext BC) {
        // Код, выполняемый после завершения обработки всех партий
        System.debug('Аккаунты успешно созданы.');
    }
}