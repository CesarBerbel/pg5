unit ufpgModelTests;

interface

uses
  ufpgDataModelTests, ADODB, uspClientDataSet;

type

  TfpgModelTests = class(TfpgDataModelTests)

  public
    procedure CarregarModelTest(poCDS: TspClientDataSet); override;
  end;

implementation

{ TfpgModelTests }

{ TfpgModelTests }



{ TfpgModelTests }

procedure TfpgModelTests.CarregarModelTest(poCDS: TspClientDataSet);
begin
  inherited;
end;

end.

