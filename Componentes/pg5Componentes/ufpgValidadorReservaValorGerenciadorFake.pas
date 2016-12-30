unit ufpgValidadorReservaValorGerenciadorFake;

interface

uses
  ufpgValidadorReservaValorGerenciador, Classes, uspClientDataSet, DB, DBClient, dxDBGrid;

const
  sDOCOK1 = '0192848';
  sDOCOK2 = '9814742221';
  sDOCOK3 = '98133331';
  sDOCOK4 = '980001041';
  sDOCOK5 = '988521041';
  sDOCOK6 = '988521097';

type
  TfpgValidadorReservaValorGerenciadorFake = class(TfpgValidadorReservaValorGerenciador)
  private
    FsTesteAtual: string;
  protected
    /// <summary>
    /// Abre a tela de reserva de valor para o documento.
    /// </summary>
    /// <remarks>
    ///  17/01/14 - Luiz.Marques - SALT 153921/5
    /// </remarks>
    procedure AbrirTelaReservaParaDocumento(pcdsMandados: TClientDataSet); override;
    function ConsultarDadosMandadosSemReservaValor(
      const pslListaDocumentos: TStringList): olevariant;
      override;
    function PegarMandadosNosDocsSelecionados: TStringList; override;
    function TestarUsaIntegracaoCustasMandados: boolean; override;
    function PegarOpcaoUsuarioDesejaReservarValor(const pbMensagemPlural: boolean): string;
      override;
    procedure CriarDataSetDadosPesquisa; override;

  public
    property fpgFakeTesteAtual: string read FsTesteAtual write FsTesteAtual;
  end;

implementation

uses
  uSajConstante, uspMensagem, SysUtils;

{ TfpgValidadorReservaValorGerenciadorFake }

function TfpgValidadorReservaValorGerenciadorFake.TestarUsaIntegracaoCustasMandados: boolean;
begin
  result := True;
  if FsTesteAtual = 'TestValidarReservaValorSemIntegracao' then
    result := False;
end;

function TfpgValidadorReservaValorGerenciadorFake.PegarMandadosNosDocsSelecionados: TStringList;
begin
  result := TStringList.Create; //PC_OK
  result.add(sDOCOK1);
  result.add(sDOCOK2);
end;

function TfpgValidadorReservaValorGerenciadorFake.ConsultarDadosMandadosSemReservaValor(
  const pslListaDocumentos: TStringList): olevariant;
const
  sCD_MANDADO_DOCOK1 = '1983888';
var
  cdsMandados: TClientDataSet;
begin
  cdsMandados := TClientDataSet.Create(nil);
  try
    cdsMandados.fieldDefs.Add('CDDOCUMENTO', ftString, 16);
    cdsMandados.fieldDefs.Add('CDMANDADO', ftString, 8);
    cdsMandados.createDataSet;

    cdsMandados.append;
    cdsMandados.FieldByName('CDMANDADO').AsString := sCD_MANDADO_DOCOK1;
    cdsMandados.FieldByName('CDDOCUMENTO').AsString := sDOCOK1;
    cdsMandados.Post;

    result := cdsMandados.Data;
  finally
    FreeAndNil(cdsMandados);
  end;
end;

function TfpgValidadorReservaValorGerenciadorFake.PegarOpcaoUsuarioDesejaReservarValor(
  const pbMensagemPlural: boolean): string;
begin
  result := s_pbNao;

  if FsTesteAtual = 'TestValidarReservaValorComIntegracaoMandadoComReservaUsuarioSim' then
  begin
    result := s_pbSim;
    Exit;
  end;

  if FsTesteAtual = 'TestValidarReservaValorComIntegracaoMandadoComReservaUsuarioCancelar' then
    result := s_pbCancelar;

end;

procedure TfpgValidadorReservaValorGerenciadorFake.AbrirTelaReservaParaDocumento(
  pcdsMandados: TClientDataSet);
begin
  Exit;
end;

procedure TfpgValidadorReservaValorGerenciadorFake.CriarDataSetDadosPesquisa;
begin
  Exit;
end;

end.
