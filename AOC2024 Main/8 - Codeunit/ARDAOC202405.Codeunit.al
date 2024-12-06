codeunit 82032 ARD_AOC202405 implements ARD_AdventOfCodeProcessor
{

    // This procedure calculates the result based on the provided ARD_AOCChallenge record.
    // It processes the challenge data or example data, splits the lines, and evaluates integer values.
    // The evaluated values are stored in a temporary record and changes are validated to compute the final result.
    //
    // Parameters:
    //   Rec: Record ARD_AOCChallenge - The record containing the challenge data.
    //   RunExample: Boolean - A flag indicating whether to run the example data or the actual challenge data.
    //
    // Returns:
    //   Integer - The calculated result based on the processed data.
    procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        TempRules: Record ARD_DoubleIntegerList temporary;
        AOCSupport: Codeunit ARD_AOCSupport;
        Lines: List of [Text];
        TestValue: Text;
        tmpList: List of [Text];
        Changes: List of [Text];
        TempInt1: Integer;
        TempInt2: Integer;
        Result: Integer;
        Count: Integer;
    begin
        Count := 0;
        Result := 0;
        if RunExample then
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach TestValue in Lines do
            if TestValue.Contains('|') then begin
                tmpList := TestValue.Split('|');
                System.Evaluate(TempInt1, tmpList.Get(1));
                System.Evaluate(TempInt2, tmpList.Get(2));
                Count += 1;
                TempRules.Init();
                TempRules."ARD_No." := Count;
                TempRules.ARD_Value1 := TempInt1;
                TempRules.ARD_Value2 := TempInt2;
                TempRules.Insert();
            end
            else
                if TestValue <> '' then
                    Changes.Add(TestValue);

        foreach TestValue in Changes do
            Result := Result + ValidateChange(TempRules, TestValue);

        exit(Result);
    end;


    /// <summary>
    /// Validates changes based on the provided record change text and updates the temporary rules record.
    /// </summary>
    /// <param name="TempRules">A temporary record of type ARD_DoubleIntegerList.</param>
    /// <param name="RecordChange">A text string containing comma-separated values representing the changes.</param>
    /// <returns>
    /// An integer value indicating the result of the validation:
    /// - Returns 0 if the validation fails.
    /// - Returns the middle value of the integer changes if the validation passes.
    /// </returns>
    /// <remarks>
    /// The procedure splits the RecordChange text into individual changes, evaluates them as integers, and adds them to a list.
    /// It then filters the TempRules record and checks if the integer changes contain specific values in a certain order.
    /// If the validation passes, it calculates and returns the middle value of the integer changes.
    /// </remarks>
    local procedure ValidateChange(var TempRules: Record ARD_DoubleIntegerList; RecordChange: Text): Integer
    var
        TextChanges: List of [Text];
        IntChanges: List of [Integer];
        Change: Text;
        TempInt: Integer;
    begin
        TextChanges := RecordChange.split(',');
        foreach Change in TextChanges do begin
            System.Evaluate(TempInt, Change);
            IntChanges.Add(TempInt);
        end;

        TempRules.Setfilter("ARD_No.", '<>%1', 0);
        if TempRules.FindSet() then
            repeat
                if (IntChanges.Contains(TempRules.ARD_Value1)) AND (IntChanges.Contains(TempRules.ARD_Value2)) then
                    if IntChanges.indexof(TempRules.ARD_Value1) > IntChanges.indexof(TempRules.ARD_Value2) then
                        exit(0);
            until TempRules.Next() = 0;

        TempInt := System.Round(IntChanges.Count() / 2, 1, '>');
        TempInt := IntChanges.Get(TempInt);
        exit(TempInt);
    end;

    /// Calculates the result based on the provided ARD_AOCChallenge record.
    /// </summary>
    /// <param name="Rec">The ARD_AOCChallenge record containing the challenge data.</param>
    /// <param name="RunExample">Boolean flag indicating whether to run the example data or the actual challenge data.</param>
    /// <returns>Returns an integer representing the calculated result.</returns>
    /// <remarks>
    /// This procedure processes the challenge data by splitting it into lines and evaluating specific values.
    /// It then stores these values in a temporary record and processes any changes to calculate the final result.
    /// </remarks>
    procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        TempRules: Record ARD_DoubleIntegerList temporary;
        AOCSupport: Codeunit ARD_AOCSupport;
        Lines: List of [Text];
        TestValue: Text;
        tmpList: List of [Text];
        Changes: List of [Text];
        TempInt1: Integer;
        TempInt2: Integer;
        Result: Integer;
        Count: Integer;
    begin
        Count := 0;
        Result := 0;
        if RunExample then
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach TestValue in Lines do
            if TestValue.Contains('|') then begin
                tmpList := TestValue.Split('|');
                System.Evaluate(TempInt1, tmpList.Get(1));
                System.Evaluate(TempInt2, tmpList.Get(2));
                Count += 1;
                TempRules.Init();
                TempRules."ARD_No." := Count;
                TempRules.ARD_Value1 := TempInt1;
                TempRules.ARD_Value2 := TempInt2;
                TempRules.Insert();
            end
            else
                if TestValue <> '' then
                    Changes.Add(TestValue);

        foreach TestValue in Changes do
            Result := Result + FixAlignmentChange(TempRules, TestValue);

        exit(Result);
    end;

    // This procedure fixes the alignment change based on the given record change.
    // It processes the changes and ensures that the order of integers in the list is corrected
    // according to the rules defined in the TempRules record.
    // If any changes are made, it returns the middle value of the corrected list.
    // If no changes are made, it returns 0.
    //
    // Parameters:
    //   - TempRules: Record ARD_DoubleIntegerList (ByRef) - Temporary record containing the alignment rules.
    //   - RecordChange: Text - Comma-separated string of integer changes.
    //
    // Returns:
    //   - Integer - The middle value of the corrected list if changes are made, otherwise 0.
    local procedure FixAlignmentChange(var TempRules: Record ARD_DoubleIntegerList; RecordChange: Text): Integer
    var
        TextChanges: List of [Text];
        IntChanges: List of [Integer];
        Change: Text;
        TempInt: Integer;
        Processing: Boolean;
        DataFixed: Boolean;
        PerfectRun: Boolean;
        Index1: Integer;
        Index2: Integer;
    begin
        DataFixed := false;
        TextChanges := RecordChange.split(',');
        foreach Change in TextChanges do begin
            System.Evaluate(TempInt, Change);
            IntChanges.Add(TempInt);
        end;

        Processing := true;
        while Processing do begin
            PerfectRun := true;
            TempRules.Setfilter("ARD_No.", '<>%1', 0);
            if TempRules.FindSet() then
                repeat
                    if (IntChanges.Contains(TempRules.ARD_Value1)) AND (IntChanges.Contains(TempRules.ARD_Value2)) then
                        if IntChanges.indexof(TempRules.ARD_Value1) > IntChanges.indexof(TempRules.ARD_Value2) then begin
                            DataFixed := true;
                            PerfectRun := false;
                            Index1 := IntChanges.indexof(TempRules.ARD_Value1);
                            Index2 := IntChanges.indexof(TempRules.ARD_Value2);

                            TempInt := IntChanges.Get(Index1);
                            IntChanges.Set(Index1, IntChanges.Get(IntChanges.indexof(TempRules.ARD_Value2)));
                            IntChanges.Set(Index2, TempInt);
                        end;
                until TempRules.Next() = 0;

                if PerfectRun then
                    Processing := false;
        end;

        if DataFixed then begin
            TempInt := System.Round(IntChanges.Count() / 2, 1, '>');
            TempInt := IntChanges.Get(TempInt);
            exit(TempInt);
        end;

        exit(0);
    end;

}
