codeunit 82026 ARD_AOCSupport
{
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
}
