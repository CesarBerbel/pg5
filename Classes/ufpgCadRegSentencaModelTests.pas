unit ufpgCadRegSentencaModelTests;

interface

uses
  ufpgDataModelTests, ADODB, FutureWindows, uspClientDataSet;

type
  TffpgCadRegSentencaModelTests = class(TfpgDataModelTests)
  private
  public
    FsProcesso: string;
    procedure CarregarModelTest(poDs: TspClientDataSet); override;
  end;

implementation

{ TffpgCadRegSentencaModelTests }

procedure TffpgCadRegSentencaModelTests.CarregarModelTest(poDs:
    TspClientDataSet);
begin
  inherited;
  FsProcesso := poDs.FieldByName('PROCESSO').AsString;
  //  sarMotivo := poDs.FieldByName('MOTIVO').AsString;
  //  sarComplemento := poDs.FieldByName('COMPLEMENTO').AsString;
end;

end.

