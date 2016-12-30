//23/05/2016 - LUCIANO.FAGUNDES - SALT: 186660/25/5
//Refatorãção
unit ufpgDesmembraProcTests;

interface

uses
  ufpgGUITestCase, ufpgDataModelTests, ufpgDesmembraProcModelTests, ufpgDesmembraProc,
  FutureWindows;

type
  TffpgDesmembraProcTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgDesmembraProc;
    FoDados: TffpgDesmembraProcModelTests;
    procedure DesmembramentoProcesso;
    procedure Certificado(const poWindow: IWindow);
    procedure PreencherDados;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;

  published
    procedure TestarDesmembramentoDeProcessos;

  end;

const
  CS_TIPOPARTE = 'Baixada';

var
  sMensagem: string;
  sNovoProcesso: string;

implementation

uses
  TestFrameWork, Forms, SysUtils, StrUtils, uspInterface, udigSelecaoCertificadoDigital,
  ufpgFuncoesGUITestes, ufpgCadParteRepres, usajConstante, ufpgVariaveisTestesGUI;


{ TffpgRelDemoDistribTests }

function TffpgDesmembraProcTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgDesmembraProcModelTests;
end;

procedure TffpgDesmembraProcTests.TestarDesmembramentoDeProcessos;
begin
  ExecutarRoteiroTestes(DesmembramentoProcesso);
end;

procedure TffpgDesmembraProcTests.DesmembramentoProcesso;
begin
  AbrirTela;
  FoTela := TffpgDesmembraProc(spTela);
  FoDados := TffpgDesmembraProcModelTests(spDataModelTests);

  PreencherDados;

  TFutureWindows.Expect('TfdigSelecaoCeritificadoDigital').ExecProc(Certificado);
  FoTela.ccCadastro.Execute(acSalvar);
  check((FoTela.dfProcDestino.Text <> ''), 'Não foi criado um novo processo');

  gsProcessoDesmembrado := somentenumeros(copy(FoTela.dfProcDestino.Text, 1, 15));
  //25/10/2016 - Raphael.Whitlock - Task: 67003
  FoTela.ccCadastro.Execute(acFecharForm);
  sMensagem := 'O processo ' + gsProcessoDesmembrado + ' não foi criado e/ou a pessoa ' +
    gsNomeParte + ' não foi desmembrada';
  check(FoDados.VerificaProcessoDesmembrado(FoDados.fpgNuProcessoPrinc, gsNomeParte, 'B'),
    sMensagem);
  check(FoDados.VerificaProcessoDesmembrado(gsProcessoDesmembrado, gsNomeParte, 'A'), sMensagem);
end;

procedure TffpgDesmembraProcTests.Certificado(const poWindow: IWindow);
var
  oTelaCertificado: TfdigSelecaoCeritificadoDigital;
begin
  oTelaCertificado := TfdigSelecaoCeritificadoDigital(PegarTela('fdigSelecaoCeritificadoDigital'));
  EnterTextInto(oTelaCertificado.cbCertificados, FoDados.fpgCertificado);
  oTelaCertificado.dxbbBotoesSelecionar.Click;
end;

procedure TffpgDesmembraProcTests.PreencherDados;
begin
  if (FoDados.fpgNuProcessoPrinc = STRING_INDEFINIDO) and
    (FoDados.fpgNuProcessoDes = STRING_INDEFINIDO) then
  begin
    FoDados.fpgNuProcessoPrinc := UsarProcessoArray;
    FoDados.fpgNuProcessoDes := UsarProcessoArray;
    check((FoDados.fpgNuProcessoPrinc <> STRING_INDEFINIDO) and
      (FoDados.fpgNuProcessoDes <> STRING_INDEFINIDO), 'Processos não cadastrados');
  end;

  spVerificadorTelas.RegistrarMensagem('Este processo*', '&OK');
  EnterTextInto(FoTela.dfnuProcessoOrigem.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcessoDes, False);
  sMensagem := (somentenumeros(spverificadortelas.spMensagemForm));
  //  check((copy(sMensagem, 1, 13) = sNuprocesso1), 'O Processo ' + sNuprocesso2 +
  //    ' Não está vinculado ao processo ' + sNuprocesso1);
  EnterTextInto(FoTela.dfnuProcessoOrigem.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcessoPrinc, False);

  spVerificadorTelas.RegistrarMensagem('Desmembramento realizado com sucesso', 'OK');

  FoTela.grPartes.DataSource.DataSet.First;
  FoTela.grPartes.DataSource.DataSet.Edit;
  FoTela.grPartes.DataSource.DataSet.FieldByName('CC_COPIAR').AsString := 'S';
  gsNomeParte := FoTela.grPartes.DataSource.DataSet.FieldByName('NMPESSOA').AsString;
end;

end.

