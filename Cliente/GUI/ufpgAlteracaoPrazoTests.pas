unit ufpgAlteracaoPrazoTests;

interface

uses
  ufpgGUITestCase, ufpgAlteracaoPrazoModelTests, ufpgAlteracaoPrazo, ufpgDataModelTests;

type
  TffpgAlteracaoPrazoTests = class(TfpgGUITestCase)
  private
    FoDados: TffpgAlteracaoPrazoModelTests;
    FoTela: TffpgAlteracaoPrazo;
    FsNuMandado: string;
    procedure AlteracaoPrazo;
    procedure PreencherAlteracaoPrazo;
    //    procedure SelecionarNaGrid(const poWindow: IWindow);
  protected
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  public
    procedure TearDown; override;
    property fpgNuMandado: string read FsNuMandado write FsNuMandado;
  published
    procedure TestarAlteracaoPrazo;
  end;

implementation

uses
  uspInterface, usmdSelecionaMandado, ufpgConstanteGUITests, ufpgFuncoesGUITestes, Forms, Windows;

procedure TffpgAlteracaoPrazoTests.TestarAlteracaoPrazo;
begin
  ExecutarRoteiroTestes(AlteracaoPrazo);
end;

{Comentado para caso precise selecionar um manbdado específico em processos com mais de um mandado
procedure TffpgAlteracaoFormaPgtoTests.SelecionarNaGrid(const poWindow: IWindow);
var
  oSelecionaMandado: TfsmdSelecionaMandado;
begin
  oSelecionaMandado := TfsmdSelecionaMandado(TspForm(poWindow.AsControl));
  oSelecionaMandado.grFiltro.spEncolhida := False;
  oSelecionaMandado.grFiltro.SelectedIndex := 0;
  EnterTextInto(oSelecionaMandado.grFiltro, FsNuMandado);
  if oSelecionaMandado.grDados.Fields[0].AsString = FsNuMandado then
    oSelecionaMandado.ccCadastro.Execute(acSelecionar);
end;}

procedure TffpgAlteracaoPrazoTests.PreencherAlteracaoPrazo;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.smdNumeroMandado.sajNumeroProcesso.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcesso, False);

  EnterTextInto(FoTela.fsmdClassifMandConsNovo.dfCodigo, FoDados.fpgCdClassificacao);
  FoTela.fsmdClassifMandConsNovoSpMudouValorCodigo(FoTela.fsmdClassifMandConsNovo);
  sleep(1000);

  Application.ProcessMessages;

  FoTela.mmJustificativa.Lines.Text := FoDados.fpgJustificativa;
end;

function TffpgAlteracaoPrazoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgAlteracaoPrazoModelTests;
end;

procedure TffpgAlteracaoPrazoTests.AlteracaoPrazo;
var
  sCDMandado: string;
begin
  AbrirTela;
  FoTela := TffpgAlteracaoPrazo(spTela);
  FoDados := (spDataModelTests) as TffpgAlteracaoPrazoModelTests;

  PreencherAlteracaoPrazo;

  sCDMandado := FoTela.smdNumeroMandado.smdCodigoObjetoMandado;

  FoTela.ccCadastro.Execute(acSalvar);
  check(FoDados.VerficarAlteracaoPrazo(sCDMandado, FoDados.fpgCdClassificacao),
    'O mandado ' + FoTela.smdNumeroMandado.smdNumeroMandado +
    ' não teve a classificação alterada');
end;

procedure TffpgAlteracaoPrazoTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.

