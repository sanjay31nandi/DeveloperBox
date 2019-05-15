<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Approved_stage</fullName>
        <field>StageName</field>
        <literalValue>Scheduled</literalValue>
        <name>Approved stage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Awaitng_approval</fullName>
        <field>StageName</field>
        <literalValue>Awaiting Approval</literalValue>
        <name>Awaitng approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update</fullName>
        <field>StageName</field>
        <literalValue>Closed Won</literalValue>
        <name>Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected_Approval</fullName>
        <field>StageName</field>
        <literalValue>Negotiation/Review</literalValue>
        <name>Rejected Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Check_Box</fullName>
        <field>Update_Required__c</field>
        <literalValue>1</literalValue>
        <name>Update Check Box</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update_Required</fullName>
        <actions>
            <name>Update_Check_Box</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>if( ROUND(PRIORVALUE(Roll_Up_Values__c),2) !=  ROUND(Roll_Up_Values__c,2),true,false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>total Depth update</fullName>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
