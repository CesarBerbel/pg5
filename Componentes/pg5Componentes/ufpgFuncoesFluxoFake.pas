unit ufpgFuncoesFluxoFake;

interface

uses
  ufpgFuncoesFluxo, uspSeguranca, usajConstante;

type
  TfpgFuncoesFluxoFake = class(TfpgFuncoesFluxo)
  protected
    function TestarAutorizacaoComponente(const psNomeTela, psNomeComponente: string;
      const penVerificaAutorizacao: TspVerificaAutorizacao = vaUsuario): boolean; override;
    function TestarAutorizacaoDeAcesso(const psNomeTela: string;
      const penVerificaAutorizacao: TspVerificaAutorizacao = vaUsuario): boolean; override;
    function VerificarRestricaoSubFluxoCustasParaExclusao(pncdTipoObjeto,
      pncdSubFluxo: double): boolean;
      override;
  end;

implementation

{ TfpgFuncoesFluxoFake }

function TfpgFuncoesFluxoFake.TestarAutorizacaoComponente(
  const psNomeTela, psNomeComponente: string;
  const penVerificaAutorizacao: TspVerificaAutorizacao): boolean;
begin
  result := (psNomeTela <> STRING_INDEFINIDO);
end;

function TfpgFuncoesFluxoFake.TestarAutorizacaoDeAcesso(const psNomeTela: string;
  const penVerificaAutorizacao: TspVerificaAutorizacao): boolean;
begin
  result := (psNomeTela <> STRING_INDEFINIDO);
end;

function TfpgFuncoesFluxoFake.VerificarRestricaoSubFluxoCustasParaExclusao(
  pncdTipoObjeto, pncdSubFluxo: double): boolean;
begin
  result := (pncdTipoObjeto <> NUMERO_INDEFINIDO) and (pncdSubFluxo <> NUMERO_INDEFINIDO);
end;

end.

