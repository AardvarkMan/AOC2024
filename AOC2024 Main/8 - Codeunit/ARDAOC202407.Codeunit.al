codeunit 82034 ARD_AOC202407 implements ARD_AdventOfCodeProcessor
{

    procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Decimal
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Lines: List of [Text];
        Line: Text;
        LineSplit: list of [Text];
        ValueText: List of [Text];
        TempInt: Decimal;
        textValue: Text;
        Values: List of [decimal];
        Expected: decimal;
        Result: decimal;
    begin
        Result := 0;
        if RunExample then
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach Line in Lines do begin
            LineSplit := Line.Split(':');
            System.Evaluate(Expected, LineSplit.Get(1));
            ValueText := LineSplit.Get(2).Split(' ');
            clear(Values);
            foreach textValue in ValueText do
                if textValue.Trim() <> '' then begin
                    System.Evaluate(TempInt, textValue);
                    Values.Add(TempInt);
                end;

            if CheckResult(Expected, Values.Get(1), Values, 2) then Result += Expected;
        end;

        Exit(Result);
    end;

    /// <summary>
    /// Checks if the expected value can be achieved by either adding or multiplying the current value with elements from the list.
    /// </summary>
    /// <param name="Expected">The expected value to be achieved.</param>
    /// <param name="Current">The current value to be compared and manipulated.</param>
    /// <param name="Values">The list of decimal values to be used for operations.</param>
    /// <param name="Index">The current index in the list of values.</param>
    /// <returns>True if the expected value can be achieved, otherwise false.</returns>
    local procedure CheckResult(Expected: decimal; Current: decimal; var Values: List of [decimal]; Index: decimal): boolean
    var
        Result: boolean;
    begin
        if Current > Expected then exit(false);

        if Index > Values.Count then
            Exit(Current = Expected);

        Result := CheckResult(Expected, Current + Values.Get(Index), Values, Index + 1) or CheckResult(Expected, Current * Values.Get(Index), Values, Index + 1);

        exit(Result);
    end;

    procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Decimal
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Lines: List of [Text];
        Line: Text;
        LineSplit: list of [Text];
        ValueText: List of [Text];
        TempInt: Decimal;
        textValue: Text;
        Values: List of [decimal];
        Expected: decimal;
        Result: decimal;
    begin
        Result := 0;

        if RunExample then
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach Line in Lines do begin
            LineSplit := Line.Split(':');
            System.Evaluate(Expected, LineSplit.Get(1));
            ValueText := LineSplit.Get(2).Split(' ');
            clear(Values);
            foreach textValue in ValueText do
                if textValue.Trim() <> '' then begin
                    System.Evaluate(TempInt, textValue);
                    Values.Add(TempInt);
                end;

            if CheckResult2(Expected, Values.Get(1), Values, 2) then Result += Expected;
        end;

        Exit(Result);
    end;

    /// Checks if the expected value can be achieved by performing a series of operations (addition, multiplication, or concatenation) 
    /// on the current value and elements from the provided list of values.
    /// </summary>
    /// <param name="Expected">The target value that needs to be achieved.</param>
    /// <param name="Current">The current value being evaluated.</param>
    /// <param name="Values">A list of decimal values to be used in the operations.</param>
    /// <param name="Index">The current index in the list of values.</param>
    /// <returns>Returns true if the expected value can be achieved, otherwise false.</returns>
    local procedure CheckResult2(Expected: decimal; Current: decimal; var Values: List of [decimal]; Index: decimal): boolean
    var
        ConcatValue: decimal;
        Text1: Text;
        Text2: Text;
        Result: boolean;
    begin
        if Current > Expected then exit(false);

        if Index > Values.Count then
            Exit(Current = Expected);

        Text1 := format(current);
        Text2 := Format(Values.Get(Index));
        System.Evaluate(ConcatValue, Text1 + Text2);
        Result := CheckResult2(Expected, Current + Values.Get(Index), Values, Index + 1) or CheckResult2(Expected, Current * Values.Get(Index), Values, Index + 1) or CheckResult2(Expected, ConcatValue, Values, Index + 1);

        exit(Result);
    end;

}
