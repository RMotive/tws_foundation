using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Security.Entities.Accounts;

namespace TWS_Security.Quality.Entities;
public class Q_Account
    : BQ_Entity<Account> {
    protected override Q_EntityEvaluation<Account>[] EvaluateFactory(Q_EntityEvaluation<Account>[] Container) {
        Q_EntityEvaluation<Account> success = new("Success") {
            Mock = new() {
                Id = 1,
                User = "Q_User",
                Wildcard = true,
                Password = [1, 2, 3],
                Contact = new TWS_Security.Entities.Contacts.Contact {
                    Id = 0,
                }
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Account> failure = new("All properties fail") {
            Mock = new(),
            Expectations = [
                (nameof(Account.Id), [(new PointerValidator(), 3)]),
                (nameof(Account.User), [(new RequiredValidator(), 1)]),
                (nameof(Account.Password), [(new RequiredValidator(), 1)]),
                (nameof(Account.Contact), [(new PointerValidator(true), 3)]),

            ],
        };

        return [.. Container, success, failure];
    }
}
