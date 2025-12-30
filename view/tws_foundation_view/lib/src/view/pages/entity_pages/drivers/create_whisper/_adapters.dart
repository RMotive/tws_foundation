part of 'drivers_page_create_whisper.dart';

class _EmployeesViewAdapter implements ViewConsumeAdapter {
  const _EmployeesViewAdapter();
  @override
  Future<List<ViewOutput<Employee>>> consume(int range, int pages, String input) async {
    String auth = Injector.get<SessionStorageI>().token;

    List<ViewFilterNodeI<Employee>> filters = <ViewFilterNodeI<Employee>>[];
    // -> Situations filter.
    if (input.trim().isNotEmpty) {
      // -> filters
      ViewFilterProperty<Employee> employeeNameFilter = ViewFilterProperty<Employee>();
      employeeNameFilter.property = 'Identification.Name';
      employeeNameFilter.operator = ViewFilterOperators.contains;
      employeeNameFilter.value = input;
      ViewFilterProperty<Employee> employeeLastnameFilter = ViewFilterProperty<Employee>();
      employeeLastnameFilter.property = 'Identification.Lastname';
      employeeLastnameFilter.operator = ViewFilterOperators.contains;
      employeeLastnameFilter.value = input;
      
      // -> adding filters
      List<ViewFilterProperty<Employee>> searchFilterFilters = <ViewFilterProperty<Employee>>[
        employeeNameFilter,
        employeeLastnameFilter,
      ];      
      ViewFilterLogical<Employee> searchFilterOption = ViewFilterLogical<Employee>(2, ViewFilterLogicalOperators.or, searchFilterFilters);
      filters.add(searchFilterOption);
    }

    FoundationResponseResolver<ViewOutput<Employee>> viewResolver = await FoundationServer(false).employeesService.view(
      ViewInput<Employee>.a(
        10,
        1,
        <ViewOrdering>[],
        filters
      ),
      auth,
    ).catchError(
          (Object x, StackTrace s) {
            // const CSMAdvisor('employee-future-autocomplete-field-adapter').exception('Exception catched at Future Autocomplete field consume', Exception(x), s);
            throw x;
          },
        );

    ViewOutput<Employee> viewOutput = viewResolver.resolveDirect(
      () => ViewOutput<Employee>(
        () => Employee(),
      ),
    );
    return <ViewOutput<Employee>>[viewOutput];
  }
}