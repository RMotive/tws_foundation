namespace CSM_Foundation.Database.Validations.Validators;

[AttributeUsage(AttributeTargets.Property)]
public class ExclusiveValidator
    : BValidator {

    protected readonly string Group;

    public ExclusiveValidator(string group = "") { 
        Group = group;
    }

    public override bool Evaluate(object? value) {
        return value != null;
    }

    public override bool EvaluateTyping(Type Type) {
        return true;
    }
}
