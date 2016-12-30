unit ufpgPECFake;

{*****************************************************************************
 Projeto/Sistema: SAJ / PG5
 Objetivo: Implementar a Classe TefpgPECFake para auxiliar nos testes unitários
 Criacao: 20/09/2013 - DAVID
*****************************************************************************}

interface

uses
  Classes, SysUtils, ufpgPEC, uspServidorAplicacao, usajConstante;

type
  /// <summary>
  /// Classe FAKE para Testes Unitários da ufpgPEC
  /// </summary>
  /// <remarks>
  /// 08/10/2013 - DAVID - SALT: 83015/1
  /// </remarks>
  TefpgPECFake = class(TefpgPEC)
  protected

    /// <summary>
    ///  Método Fake que retorna o parametro PrmAipDistribuiPECVaraOrigem = 'S'
    /// </summary>
    /// <param name="psCdProcesso">
    /// </param>
    /// <remarks>
    ///  08/10/2013 - DAVID - SALT: 144622/7
    /// </remarks
    function RetornarPrmAipDistribuiPECVaraOrigem(pFoSpDono: TspServidorAplicacao): string;
      override;

    /// <summary>
    ///  Método Fake que retorna 'S' para a Consulta de ExistenciaDeDados
    /// </summary>
    /// <param name="psCdProcesso">
    /// </param>
    /// <remarks>
    ///  08/10/2013 - DAVID - SALT: 144622/7
    /// </remarks
    function ConsultarSeExistemDados(const psCdProcesso: string): boolean; override;
  end;

implementation

{ TefpgPECFake }

function TefpgPECFake.ConsultarSeExistemDados(const psCdProcesso: string): boolean;
begin
  result := (psCdProcesso <> STRING_INDEFINIDO);
end;

function TefpgPECFake.RetornarPrmAipDistribuiPECVaraOrigem(
  pFoSpDono: TspServidorAplicacao): string;
begin
  result := sFLAG_SIM;
end;

end.

