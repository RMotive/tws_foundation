
using System.Reflection;

using Xunit.Sdk;

/// <summary>
/// Custom Attribute class for marking common entities tests in business quality.
/// </summary>

public class CommonFactDataAttribute : DataAttribute {
    public override IEnumerable<object[]> GetData(MethodInfo testMethod) {

        return [
            [true],
            [false]
        ];
    }
}




