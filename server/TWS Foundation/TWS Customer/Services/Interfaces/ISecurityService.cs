using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Records;

namespace TWS_Customer.Services.Interfaces;

public interface ISecurityService {
    public Task<Session> Authenticate(Credentials Credentials);
}
