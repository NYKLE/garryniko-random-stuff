using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[AddComponentMenu("Scripts/Note")]
public class NoteUtility : MonoBehaviour
{
    [HideInInspector]
    [TextAreaAttribute (10,int.MaxValue)]
    public string NoteText;
}

public static class NoteCreator
{
    [MenuItem("GarryNiko/Create Note")]  
    private static void CreateNoteObject()
    {
        GameObject GO = new GameObject("Note");
        GO.transform.position = new Vector3(0,0,0);
        var ico_asset = AssetDatabase.FindAssets("Ico_Note t:texture2D");  
        Texture2D icon = (Texture2D)AssetDatabase.LoadAssetAtPath(AssetDatabase.GUIDToAssetPath(ico_asset[0]), typeof(Texture2D));
        EditorGUIUtility.SetIconForObject(GO, (Texture2D)icon);
        NoteUtility NoteComponent = GO.AddComponent(typeof(NoteUtility)) as NoteUtility;
        GO.tag = "EditorOnly";
    }
}

[CustomEditor(typeof(NoteUtility))]
public class NoteComponentCustomEditor : Editor
{
    private static readonly string[] _dontIncludeMe = new string[]{"m_Script"};
    
    public override void OnInspectorGUI()
    {
        serializedObject.Update();
        DrawPropertiesExcluding(serializedObject, _dontIncludeMe);
        EditorGUILayout.PropertyField(this.serializedObject.FindProperty("NoteText"), GUIContent.none);
        serializedObject.ApplyModifiedProperties();
    }
}

[InitializeOnLoad]
public class NoteIcon
{
    static NoteIcon()
    {
        AssemblyReloadEvents.afterAssemblyReload += OnAfterAssemblyReload;
        HierarchyNoteIcon();
    }

    private static void OnAfterAssemblyReload()
    {
        EditorApplication.delayCall += () =>
        {
            var ico_asset = AssetDatabase.FindAssets("Ico_Note t:texture2D");  

            if (ico_asset.Length > 0)
            {
                Texture2D icon = (Texture2D)AssetDatabase.LoadAssetAtPath(AssetDatabase.GUIDToAssetPath(ico_asset[0]), typeof(Texture2D));
                var script_asset = AssetDatabase.FindAssets("NoteUtility t:script");  
                UnityEngine.Object script = (UnityEngine.Object)AssetDatabase.LoadAssetAtPath(AssetDatabase.GUIDToAssetPath(script_asset[0]), typeof(UnityEngine.Object));
                EditorGUIUtility.SetIconForObject(script, (Texture2D)icon);
            }
            else
            {
                Debug.Log("Ico_Note.png is missing, it should be placed in the same folder as this script.");
                
            }
        };
    }

    static void HierarchyNoteIcon()
    {
        EditorApplication.hierarchyWindowItemOnGUI += (int instanceID, Rect selectionRect) =>
        {
            var content = EditorGUIUtility.ObjectContent(EditorUtility.InstanceIDToObject(instanceID), null);

            if (content.image != null && content.image.name == "Ico_Note")
                GUI.DrawTexture(new Rect(selectionRect.xMin, selectionRect.yMin, 16, 16), content.image);
        };
    }
}