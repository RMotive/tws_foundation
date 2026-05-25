
using System.Reflection;
using Xunit.Sdk;
using Xunit.v3;

namespace TWS_Business.Quality.Q_Depots.Bases;

/// <summary>
/// Custom Attribute class for marking common entities tests in business quality.
/// </summary>
public class CommonFactDataAttribute : DataAttribute
{
    public override ValueTask<IReadOnlyCollection<ITheoryDataRow>> GetData(MethodInfo testMethod, DisposalTracker disposalTracker)
    {
        List<ITheoryDataRow> rows = [
            new TheoryDataRow(true),
            new TheoryDataRow(false)
        ];

        return new ValueTask<IReadOnlyCollection<ITheoryDataRow>>(rows);
    }

    public override bool SupportsDiscoveryEnumeration()
    {
        return true;
    }
}




