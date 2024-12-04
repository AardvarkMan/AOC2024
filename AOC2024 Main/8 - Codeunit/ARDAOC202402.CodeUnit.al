codeunit 82030 ARD_AOC202402 implements ARD_AdventOfCodeProcessor
{

    /// <summary>
    /// Calculates the result based on the given record and whether to run the example or not.
    /// </summary>
    /// <param name="Rec">The record containing the challenge data.</param>
    /// <param name="RunExample">Boolean indicating whether to run the example or the actual challenge data.</param>
    /// <returns>An integer representing the calculated result.</returns>
    /// <remarks>
    /// This procedure processes a list of text values, splits them into individual values, and evaluates each value.
    /// It checks if the values are increasing or decreasing and if the difference between consecutive values is within a certain range.
    /// If the values are either strictly increasing or decreasing and within the range, the result is incremented.
    /// </remarks>
    procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Inputs: list of [Text];
        TestValue: Text;
        Values: List of [Text];
        tmpInteger1: Integer;
        tmpInteger2: Integer;
        Increasing: Boolean;
        Decreasing: Boolean;
        FirstValue: Boolean;
        OverRange: Boolean;
        Result: Integer;
    begin
        Result := 0;
        tmpInteger2 := 0;
        if RunExample then
            Inputs := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Inputs := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach TestValue in Inputs do begin
            Values := AOCSupport.SplitValues(TestValue);
            Increasing := false;
            Decreasing := false;
            FirstValue := true;
            OverRange := false;
            foreach TestValue in Values do begin
                System.Evaluate(tmpInteger1, TestValue);
                if FirstValue = false then begin
                    if tmpInteger1 > tmpInteger2 then Increasing := true;
                    if tmpInteger1 < tmpInteger2 then Decreasing := true;

                    if Abs(tmpInteger1 - tmpInteger2) > 3 then OverRange := true;
                    if (tmpInteger1 - tmpInteger2) = 0 then OverRange := true;
                end;
                FirstValue := false;
                tmpInteger2 := tmpInteger1;
            end;

            if (OverRange = false) AND (Increasing <> Decreasing) then Result := Result + 1;
        end;
        exit(Result);
    end;

    /// <summary>
    /// Calculates the result based on the provided record and example flag.
    /// </summary>
    /// <param name="Rec">The record of type ARD_AOCChallenge containing the challenge data.</param>
    /// <param name="RunExample">A boolean flag indicating whether to run the example data or the actual challenge data.</param>
    /// <returns>An integer representing the calculated result.</returns>
    /// <remarks>
    /// This procedure processes the input data by splitting it into lines and evaluating each line using the EvaluateList function.
    /// Depending on the evaluation result, it increments the result or fail counters.
    /// </remarks>    
    procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Inputs: list of [Text];
        TestValue: Text;
        Result: Integer;
        Fails: Integer;
    begin
        Result := 0;
        Fails := 0;
        if RunExample then
            Inputs := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Inputs := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach TestValue in Inputs do
            case true of
                EvaluateList(TestValue, 0):
                    Result := Result + 1;
                EvaluateList(TestValue, 1):
                    Result := Result + 1;
                EvaluateList(TestValue, -1):
                    Result := Result + 1;
                EvaluateList(TestValue, -2):
                    Result := Result + 1;
                else
                    Fails := Fails + 1;
            end;

        exit(Result);
    end;

    /// <summary>
    /// Evaluates a list of text values to determine if they are either strictly increasing or decreasing
    /// within a specified range. If the difference between consecutive values exceeds 3 or if there are
    /// equal consecutive values, the evaluation fails.
    /// </summary>
    /// <param name="TestValue">The text value to be evaluated.</param>
    /// <param name="Offset">The offset used to adjust the position in the list when a failure occurs.</param>
    /// <returns>Returns true if the list is either strictly increasing or decreasing within the specified range; otherwise, false.</returns>
    local procedure EvaluateList(TestValue: Text; Offset: Integer): Boolean
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Values: List of [Text];
        tmpInteger1: Integer;
        tmpInteger2: Integer;
        Increasing: Boolean;
        Decreasing: Boolean;
        FirstValue: Boolean;
        OverRange: Boolean;
        Processing: Boolean;
        HasFailed: Boolean;
        Count: Integer;
    begin
        tmpInteger2 := 0;
        Values := AOCSupport.SplitValues(TestValue);
        Increasing := false;
        Decreasing := false;
        FirstValue := true;
        OverRange := false;
        Processing := true;
        HasFailed := false;
        Count := 1;
        while Processing do begin
            TestValue := Values.Get(Count);
            System.Evaluate(tmpInteger1, TestValue);
            if FirstValue = false then begin
                if tmpInteger1 > tmpInteger2 then Increasing := true;
                if tmpInteger1 < tmpInteger2 then Decreasing := true;

                if Abs(tmpInteger1 - tmpInteger2) > 3 then OverRange := true;
                if (tmpInteger1 - tmpInteger2) = 0 then OverRange := true;
            end;

            if (HasFailed = false) AND (FirstValue = false) AND ((OverRange = true) OR (Increasing = Decreasing)) then begin
                FirstValue := true;
                HasFailed := true;
                Increasing := false;
                Decreasing := false;
                OverRange := false;
                if ((Count + Offset) > 0) AND ((Count + Offset) <= Values.Count) then Values.RemoveAt(Count + Offset);
                Count := 0;
            end else
                FirstValue := false;

            Count := Count + 1;
            tmpInteger2 := tmpInteger1;
            if Count > Values.Count then Processing := false;
        end;

        if (OverRange = false) AND (Increasing <> Decreasing) then exit(true) else exit(false);
    end;

}
