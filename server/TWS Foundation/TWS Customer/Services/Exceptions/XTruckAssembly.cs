
using System.Net;

using CSM_Foundation.Core.Bases;

namespace TWS_Customer.Services.Exceptions;
public class XTruckAssembly : BException<XTruckAssemblySituation> {

    public XTruckAssembly(XTruckAssemblySituation Situation)
        : base($"", Situation, HttpStatusCode.BadRequest, null) {
    }

    protected override Dictionary<XTruckAssemblySituation, string> ResolveAdvise() {
        return new Dictionary<XTruckAssemblySituation, string> {
            { XTruckAssemblySituation.RequiredManufacturer, $"None Model data found." },
            { XTruckAssemblySituation.RequiredPlates, $"None Plates data found." },
            { XTruckAssemblySituation.ManufacturerNotExist, $"The given Model not exist" },
            { XTruckAssemblySituation.SitutionNotExist, $"The given Situation ID not exist" }
        };
    }
}

public enum XTruckAssemblySituation {
    RequiredManufacturer,
    RequiredPlates,
    ManufacturerNotExist,
    SitutionNotExist
}
