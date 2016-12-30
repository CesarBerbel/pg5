unit ufpgValidadorCriacaoNovoDocumentoGerenciadorFake;

interface

uses
  SysUtils, Classes, ufpgValidadorCriacaoNovoDocumentoGerenciador;

type
  TfpgValidadorCriacaoNovoDocumentoGerenciadorFake = class(
    TfpgValidadorCriacaoNovoDocumentoGerenciador)
  private
    FsCdUsuarioLogado: string;
    FbUsuarioNaListaDeGrupos: boolean;
  protected
    function PegarCdUsuarioLogado: string; override;
    function TestarUsuarioPertenceAoGrupoDoDocumento(const psCdGrupoModelo: string): boolean;
      override;
    function TestarUsuarioEstaNoCompartDoModelo(pnCdModelo: integer): boolean; override;
  public
    property fpgCdUsuarioLogado: string read FsCdUsuarioLogado write FsCdUsuarioLogado;
    property fpgUsuarioNaListaDeGrupos: boolean read FbUsuarioNaListaDeGrupos   
      write FbUsuarioNaListaDeGrupos;
  end;

implementation

function TfpgValidadorCriacaoNovoDocumentoGerenciadorFake.PegarCdUsuarioLogado: string;
begin
  result := fpgCdUsuarioLogado;
end;

function TfpgValidadorCriacaoNovoDocumentoGerenciadorFake.TestarUsuarioPertenceAoGrupoDoDocumento(
  const psCdGrupoModelo: string): boolean;
begin
  result := fpgUsuarioNaListaDeGrupos;
end;

function TfpgValidadorCriacaoNovoDocumentoGerenciadorFake.TestarUsuarioEstaNoCompartDoModelo(
  pnCdModelo: integer): boolean;
begin
  //manter comportamento antigo 
  result := False;
end;

end.
