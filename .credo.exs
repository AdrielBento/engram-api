%{
  configs: [
    %{
      name: "default",
      checks: %{
        disabled: [
          # Add this line
          {Credo.Check.Readability.ModuleDoc, []}
          # ... other disabled checks ...
        ]
      }
    }
  ]
}
