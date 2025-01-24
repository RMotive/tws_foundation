using System.Net;

using CSM_Foundation.Core.Bases;

namespace CSM_Foundation.Server.Exceptions;
public class XDisposition
    : BException<XDispositionSituation> {
    public XDisposition(XDispositionSituation Situation)
        : base($"Wrong disposition configuration", Situation, HttpStatusCode.BadRequest, null) {

        this.Situation = Situation;
        Advise = Situation switch {
            XDispositionSituation.Value => "Wrong CSMDisposition header acceptance value",
            _ => throw new ArgumentException(null, nameof(Situation)),
        };
    }
}

public enum XDispositionSituation {
    Value,
}
