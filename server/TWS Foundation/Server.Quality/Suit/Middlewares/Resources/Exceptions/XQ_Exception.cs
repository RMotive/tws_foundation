using System.Net;

using CSM_Foundation.Server.Bases;

namespace TWS_Foundation.Quality.Suit.Middlewares.ReDatabasess.Exceptions;
public class XQ_Exception
    : BServerTransactionException<XQ_ExceptionSituation> {
    public XQ_Exception()
        : base("quality exception mock", HttpStatusCode.BadRequest, null) {
    }
}

public enum XQ_ExceptionSituation {
    Quality
}