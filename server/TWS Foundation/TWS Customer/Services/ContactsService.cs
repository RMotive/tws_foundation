﻿
using CSM_Foundation.Databases.Models.Out;

using TWS_Customer.Services.Interfaces;

using TWS_Security.Depots;
using TWS_Security.Sets;

namespace TWS_Customer.Services;
public class ContactsService
    : IContactsService {
    private readonly ContactsDepot Contacts;
    public ContactsService(ContactsDepot contacts) {
        Contacts = contacts;
    }
    public async Task<DatabasesTransactionOut<Contact>> Create(Contact[] contact) {
        return await Contacts.Create(contact);
    }
}