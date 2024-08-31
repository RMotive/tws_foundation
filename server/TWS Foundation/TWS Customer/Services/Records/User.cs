

using TWS_Security.Sets;

namespace TWS_Customer.Services.Records;
public class User {
    public int Id { get; set; }

    public string Username { get; set; } = null!;

    public Contact? Contact { get; set; }
}
