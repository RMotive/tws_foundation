using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Security.Entities.Contacts;

namespace TWS_Security.Quality.Entities;
public class Q_Contact
    : BQ_Entity<Contact> {
    protected override Q_EntityEvaluation<Contact>[] EvaluateFactory(Q_EntityEvaluation<Contact>[] Container) {
        Q_EntityEvaluation<Contact> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "",
                Lastname = "",
                Email = "",
                Phone = ""
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Contact> failure = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Name = "",
                Lastname = "",
                Email = "",
                Phone = ""
            },
            Expectations = [
                (nameof(Contact.Id), [(new PointerValidator(), 3)]),
                (nameof(Contact.Name), [(new LengthValidator(), 2)]),
                (nameof(Contact.Lastname), [(new LengthValidator(), 2)]),
                (nameof(Contact.Email), [(new LengthValidator(), 2)]),
                (nameof(Contact.Phone), [(new LengthValidator(), 2)])
            ],
        };

        return [.. Container, success, failure];
    }
}
