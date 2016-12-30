unit ufpgCadRegSentencaTests;

interface

uses
  TestFramework, ufpgGUITestCase, FutureWindows, Windows, ADODB, ufpgMenu, Forms,
  uspForm, Classes, SysUtils, uspInterface;

type
  TffpgCadRegSentencaTests = class(TfpgGUITestCase)
  published
    procedure TestarRegistroDeSentenca;
  end;

implementation

{ TffpgCadRegSentencaTests }

uses
  ufpgCadRegSentenca, ufpgCadRegSentencaModelTests, ufpgConsTipoMvProcesso;

function RetornarFormulario(psNomeFormulario: string): TForm;
var
  i: integer;
  oForm: TForm;
begin
  result := nil;
  for i := 0 to Screen.FormCount - 1 do
  begin
    oForm := Screen.Forms[i];
    if LowerCase(oForm.Name) = LowerCase(psNomeFormulario) then
    begin
      result := oForm;
      Break;
    end;
  end;
end;

procedure TffpgCadRegSentencaTests.TestarRegistroDeSentenca;
var
  oTela: TffpgCadRegSentenca;
  oModelTests: TffpgCadRegSentencaModelTests;
  oForm: TForm;
begin
  try
    oTela := TffpgCadRegSentenca(spTela);
    oModelTests := TffpgCadRegSentencaModelTests.Create;

    spDados.First;
    while (not spDados.EOF) do
    begin
      oModelTests.CarregarModelTest(spDados);
      EnterTextInto(oTela.dfCodigo.FdfNumeroProcessoExterno, oModelTests.FsProcesso);
      CheckCampoPreenchido(oTela.dfCodigo.FdfNumeroProcessoExterno, oModelTests);
      oTela.csTipoMv.pbConsulta.Click;
      sleep(1000);
      oForm := RetornarFormulario('ffpgConsTipoMvProcesso');
      sleep(1000);
      TffpgConsTipoMvProcesso(oForm).ccCadastro.Selecione;
      TFutureWindows.Expect('TMessageForm', 60000).ExecProc(PressionarNaoNaTelaDeConfirmacao);
      oTela.ccCadastro.Limpe;
      spDados.Next;
    end;
  finally
    FreeAndNil(oModelTests);
  end;
end;

initialization
  RegisterTest('Interface\Andamento\Registro de sentença', TffpgCadRegSentencaTests.Suite);

end.

