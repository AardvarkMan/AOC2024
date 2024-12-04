codeunit 82026 ARD_AOCSupport
{
    // This procedure takes a text input and splits it into a list of text lines.
    // It removes any empty lines and trims whitespace from each line.
    //
    // Parameters:
    //   Input: Text - The input text to be split into lines.
    //
    // Returns:
    //   List of [Text] - A list containing the non-empty, trimmed lines from the input text.
    procedure SplitLines(Input: Text): List of [Text]
    var
        DirtyList: List of [Text];
        Results: List of [Text];
        NewLineCharacter: Char;
        LineText: Text;
    begin
        NewLineCharacter := 10;

        DirtyList := Input.Split(NewLineCharacter);

        foreach LineText in DirtyList do
            if StrLen(LineText.Trim()) > 0 then
                Results.Add(LineText.Trim());

        exit(Results);
    end;


    /// <summary>
    /// Splits the input text into a list of trimmed text values based on a specified delimiter.
    /// </summary>
    /// <param name="Input">The input text to be split.</param>
    /// <returns>A list of trimmed text values.</returns>
    procedure SplitValues(Input: Text): List of [Text]
    var
        DirtyList: List of [Text];
        Results: List of [Text];
        NewLineCharacter: Char;
        LineText: Text;
    begin
        NewLineCharacter := 32;

        DirtyList := Input.Split(NewLineCharacter);

        foreach LineText in DirtyList do
            if StrLen(LineText.Trim()) > 0 then
                Results.Add(LineText.Trim());

        exit(Results);
    end;
}
