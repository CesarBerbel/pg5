unit ufpgDocumentoServSelectCadastroMetadadosTests;

/// <summary>
///  Trata-se de teste específico para garantir que as projeções entre o spSlect SelectCadastro
///  definido em TedigDocumentoServ e acrescidode colunas em TefpgDocumentoServ permaneça com a
///  mesma projeção do union inserido no método
///  TefpgDocumentoServ.AdicionarConsultaUnion_SelectCadastro.
///  como este union é feito apenas na seleçãode peças para devolução de pedido de informação
///  para o SG5, seria muito fácil as projeções não mais coincidirem e isto ficar assim de forma
///  despercebida.
///  Por isso existe o spSelect TefpgDocumentoServ.SelectCadastroEDTProcFisico, que retorna a
///  mesma projeção do union e aqui nesta classe de teste osdois spSlects são feitos e seus metadados
///  comaprados, quanto a projeção.
/// </summary>
///
/// <remarks>
///
/// </remarks>
interface


uses
  TestFrameWork, Windows, uspForm, Forms, FutureWindows, SysUtils, uspTestCase,
  GUITesting, uspFuncoesExcel, udigDocumento, usajConstante;

type
  TfpgDocumentoServSelectCadastroMetadadosTests = class(TTestCase)
  private

    FedigDocumento: TedigDocumento;
    function CalcularTextoProjecao: string;
    function calcularMensagemDifProjecao(
      const psSelectCadastro, psSelectCadastroEDTProcFisico: string): string;
  public
    procedure Setup; override;
    procedure TearDown; override;
  published
    // Test methods
    procedure TestMetadadoSelectCadastro;
    procedure TestMetadadoSelectCadastroEDTProcFisico;
    procedure TestMetadadoSelectCadastroIgualSelectCadastroEDTProcFisico;
  end;

implementation

uses
  typinfo, DB, usajConfig, ufpgDevolucaoPedidoInformacao, Classes;

const
  sSEMCAMPOS = '{ContadorCampos:0}';


{ TfpgDocumentoServSelectCadastroMetadadosTests }


procedure TfpgDocumentoServSelectCadastroMetadadosTests.TestMetadadoSelectCadastroEDTProcFisico;
begin
  FedigDocumento.spSelect := 'SelectCadastroEDTProcFisico';
  FedigDocumento.MetaDados;

  CheckNotEqualsString(CalcularTextoProjecao, sSEMCAMPOS);
end;

function TfpgDocumentoServSelectCadastroMetadadosTests.CalcularMensagemDifProjecao(
  const psSelectCadastro, psSelectCadastroEDTProcFisico: string): string;
var
  slLinhaSelectCadastro: TStringList;
  slLinhaSelectCadastroEDTProcFisico: TStringList;
  i: integer;
begin
  result := 'Os spSelects ''TefpgDocumentoServ.SelectCadastro'' e ' +
    '''TefpgDocumentoServ.SelectCadastroEDTProcFisico'' devem ter a mesma projeção.' +
    #13#10 + 'Diferenças encontradas:' + #13#10;

  slLinhaSelectCadastro := TStringList.Create;
  slLinhaSelectCadastroEDTProcFisico := TStringList.Create;
  try
    slLinhaSelectCadastro.Text := psSelectCadastro;
    slLinhaSelectCadastroEDTProcFisico.Text := psSelectCadastroEDTProcFisico;


    for i := 0 to slLinhaSelectCadastro.Count - 1 do
    begin
      if i < slLinhaSelectCadastroEDTProcFisico.Count then
      begin
        if slLinhaSelectCadastro.Strings[i] <> slLinhaSelectCadastroEDTProcFisico.Strings[i] then
        begin
          result := result + Format('<SelectCadastro:%s> - <SelectCadastroEDTProcFisico:%s>',
            [slLinhaSelectCadastro.Strings[i], slLinhaSelectCadastroEDTProcFisico.Strings[i]]) +
            #13#10;
        end;
      end
      else
      begin
        result := result + Format('<SelectCadastro:%s> - <SelectCadastroEDTProcFisico:%s>',
          [slLinhaSelectCadastro.Strings[i], '(vazio)']) + #13#10;
      end;
    end;

    if slLinhaSelectCadastroEDTProcFisico.Count > slLinhaSelectCadastro.Count then
    begin
      for i := slLinhaSelectCadastro.Count to slLinhaSelectCadastroEDTProcFisico.Count - 1 do
      begin
        result := result + Format('<SelectCadastro:%s> - <SelectCadastroEDTProcFisico:%s>',
          ['(vazio)', slLinhaSelectCadastroEDTProcFisico.Strings[i]]) + #13#10;
      end;
    end;
  finally
    slLinhaSelectCadastroEDTProcFisico.Free;
    slLinhaSelectCadastro.Free;
  end;
end;

procedure TfpgDocumentoServSelectCadastroMetadadosTests.
TestMetadadoSelectCadastroIgualSelectCadastroEDTProcFisico;
var
  sSelectCadastro: string;
  sSelectCadastroEDTProcFisico: string;
begin
  FedigDocumento.spSelect := 'SelectCadastro';
  FedigDocumento.MetaDados;

  sSelectCadastro := CalcularTextoProjecao;

  FedigDocumento.spSelect := 'SelectCadastroEDTProcFisico';
  FedigDocumento.MetaDados;

  sSelectCadastroEDTProcFisico := CalcularTextoProjecao;

  CheckEqualsString(sSelectCadastro, sSelectCadastroEDTProcFisico,
    CalcularMensagemDifProjecao(sSelectCadastro, sSelectCadastroEDTProcFisico));
end;


procedure TfpgDocumentoServSelectCadastroMetadadosTests.Setup;
begin
  FedigDocumento := TedigDocumento.Create(nil); //PC_OK
  //  spNomeTela := 'ffpgDevolucaoPedidoInformacao';
  // 20/03/2015 - anibal.ferreira - SALT: 137970/1/197
  //  spAbrirTelaNoSetUp := False;
  inherited;
end;

procedure TfpgDocumentoServSelectCadastroMetadadosTests.TearDown;
begin
  FedigDocumento.Free; //PC_OK
  FedigDocumento := nil;
  inherited;
end;

procedure TfpgDocumentoServSelectCadastroMetadadosTests.TestMetadadoSelectCadastro;
begin
  FedigDocumento.spSelect := 'SelectCadastro';
  FedigDocumento.MetaDados;
  CheckNotEqualsString(CalcularTextoProjecao, sSEMCAMPOS);
end;

function TfpgDocumentoServSelectCadastroMetadadosTests.CalcularTextoProjecao: string;
var
  i: integer;
begin
  result := '{ContadorCampos:' + IntToStr(FedigDocumento.FieldDefs.Count);
  if FedigDocumento.FieldDefs.Count > 0 then
  begin
    result := result + ',Campos:{' + #13#10;
    for i := 0 to FedigDocumento.FieldDefs.Count - 1 do
    begin

      if i > 0 then
      begin
        result := result + ',' + #13#10;
      end;

      result := result + '{i:' + IntToStr(I);
      result := result + ',Name:' + FedigDocumento.FieldDefs.Items[i].Name;
      result := result + ',DataType:' + GetEnumName(TypeInfo(TFieldType),
        integer(FedigDocumento.FieldDefs.Items[i].DataType));
      //result := result + ',Size:' + IntToStr(FedigDocumento.FieldDefs.Items[i].Size) +
      result := result + '}';

      if i = (FedigDocumento.FieldDefs.Count - 1) then
      begin
        result := result + #13#10;
      end;
    end;
    result := result + '}' + #13#10;
  end;
  result := result + '}';
end;


initialization
  RegisterTest(
    'Unitário\Andamento\Envio de Processo ao 2º Grau\Devolução do Pedido de Infomações' +
    '(Teste select para seleção de peças)',
    TfpgDocumentoServSelectCadastroMetadadosTests.Suite);
end.

