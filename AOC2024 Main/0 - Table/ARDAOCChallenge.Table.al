table 82024 ARD_AOCChallenge
{
    Caption = 'AOC Challenge';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "ARD_No."; Integer)
        {
            Caption = 'No.';
            ToolTip = 'Record number';
            AutoIncrement = true;
        }
        field(2; ARD_Day; Integer)
        {
            Caption = 'Day';
            Tooltip = 'Advent of Code Day';
        }
        field(3; ARD_Result1; Integer)
        {
            Caption = 'Result 1';
            ToolTip = 'Result value 1';
        }
        field(4; ARD_Result2; Integer)
        {
            Caption = 'Result 2';
            ToolTip = 'Result Value 2';
        }
        field(5; ARD_Challenge1Text; Media)
        {
            Caption = 'Challenge 1 Text';
            ToolTip = 'Challenge input text 1';
        }
        field(6; ARD_Challenge2Text; Media)
        {
            Caption = 'Challenge 2 Text';
            ToolTip = 'Challenge input text 2';
        }
        field(7; ARD_SimpleData; Media)
        {
            Caption = 'Challenge Simple Example';
            ToolTip = 'The simple data set example for the challenge';
        }
        field(8; ARD_ChallengeData; Media)
        {
            Caption = 'Challenge Data';
            ToolTip = 'Challenge data set';
        }
        field(9; ARD_Challenge1Complete; Boolean)
        {
            Caption = 'Challenge 1 Complete';
            ToolTip = 'Challenge 1 Completed';
        }
        field(10; ARD_Challange2Complete; Boolean)
        {
            Caption = 'Challenge 2 Complete';
            ToolTip = 'Challenge 2 Completed';
        }
    }
    keys
    {
        key(PK; "ARD_No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(brick; "ARD_No.", ARD_Day){}
        fieldgroup(dropdown; "ARD_No.", ARD_Day){}
    }

    procedure RetrieveChallenge1Text(): Text
    var
        TempBlob: codeunit "Temp Blob";
        VarOutStream: OutStream;
        VarInStream: InStream;
        ChallengeText: Text;
    begin
        ChallengeText := '';
        TempBlob.CreateOutStream(VarOutStream);
        TempBlob.CreateInStream(VarInStream);

        if Rec.ARD_Challenge1Text.ExportStream(VarOutStream) then
            VarInStream.Read(ChallengeText);

        exit(ChallengeText);
    end;

    procedure RetrieveChallenge2Text(): Text
    var
        TempBlob: codeunit "Temp Blob";
        VarOutStream: OutStream;
        VarInStream: InStream;
        ChallengeText: Text;
    begin
        ChallengeText := '';
        TempBlob.CreateOutStream(VarOutStream);
        TempBlob.CreateInStream(VarInStream);

        if Rec.ARD_Challenge2Text.ExportStream(VarOutStream) then
            VarInStream.Read(ChallengeText);

        exit(ChallengeText);
    end;

    procedure RetrieveChallengeExample(): Text
    var
        TempBlob: codeunit "Temp Blob";
        VarOutStream: OutStream;
        VarInStream: InStream;
        ChallengeText: Text;
    begin
        ChallengeText := '';
        TempBlob.CreateOutStream(VarOutStream);
        TempBlob.CreateInStream(VarInStream);

        if Rec.ARD_SimpleData.ExportStream(VarOutStream) then
            VarInStream.Read(ChallengeText);

        exit(ChallengeText);
    end;

    procedure RetrieveChallengeData(): Text
    var
        TempBlob: codeunit "Temp Blob";
        VarOutStream: OutStream;
        VarInStream: InStream;
        ChallengeText: Text;
    begin
        ChallengeText := '';
        TempBlob.CreateOutStream(VarOutStream);
        TempBlob.CreateInStream(VarInStream);

        if Rec.ARD_ChallengeData.ExportStream(VarOutStream) then
            VarInStream.Read(ChallengeText);

        exit(ChallengeText);
    end;
}
