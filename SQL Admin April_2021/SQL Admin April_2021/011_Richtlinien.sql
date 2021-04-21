--Richtlinien sollen best Settings überwachen

/*
zB Db sollten auf getrennten Laufwerken (ldf und mdf)
Gast (jeder der ein Login dürfte die DB betreten , wann das Gastkonto aktiv ist
--> keine gute Idee

Ort: Backupdatei und Datenbankdateien auf getrennten Laufwerken


Facets: sind die Dinge , die wir beobachten können


Bedingungen sind Regeln die wir aufstellen:

"Gast darf nicht aktiv sein"


Richtinien: Wenn Regeln angewendet werden
*/

Declare @condition_id int
EXEC msdb.dbo.sp_syspolicy_add_condition @name=N'RecovModel_FULL', @description=N'', @facet=N'Database', @expression=N'<Operator>
  <TypeClass>Bool</TypeClass>
  <OpType>EQ</OpType>
  <Count>2</Count>
  <Attribute>
    <TypeClass>Numeric</TypeClass>
    <Name>RecoveryModel</Name>
  </Attribute>
  <Function>
    <TypeClass>Numeric</TypeClass>
    <FunctionType>Enum</FunctionType>
    <ReturnType>Numeric</ReturnType>
    <Count>2</Count>
    <Constant>
      <TypeClass>String</TypeClass>
      <ObjType>System.String</ObjType>
      <Value>Microsoft.SqlServer.Management.Smo.RecoveryModel</Value>
    </Constant>
    <Constant>
      <TypeClass>String</TypeClass>
      <ObjType>System.String</ObjType>
      <Value>Full</Value>
    </Constant>
  </Function>
</Operator>', @is_name_condition=0, @obj_name=N'', @condition_id=@condition_id OUTPUT
Select @condition_id

GO

Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'policy_ObjectSet', @facet=N'Database', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'policy_ObjectSet', @type_skeleton=N'Server/Database', @type=N'DATABASE', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id

EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database', @level_name=N'Database', @condition_name=N'', @target_set_level_id=0


GO

Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'DB_RecModel_Full', @condition_name=N'RecovModel_FULL', @execution_mode=0, @policy_id=@policy_id OUTPUT, @object_set=N'policy_ObjectSet'
Select @policy_id


GO



