using System.Net;

using CSM_Foundation.Core.Bases;

namespace TWS_Foundation.Quality.Suit.Middlewares.Resources.Exceptions;
public class XQ_Exception
    : BException<XQ_ExceptionSituation> {
    public XQ_Exception()
        : base("quality exception mock", XQ_ExceptionSituation.Quality, HttpStatusCode.BadRequest, null) {
    }
}

public enum XQ_ExceptionSituation {
    Quality
}