using UnityEngine;
using UnityEditor;
using System.IO;

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
        Camera cam = SceneView.lastActiveSceneView.camera;
        GO.transform.position = cam.transform.position + cam.transform.forward*0.5f;
        EditorGUIUtility.SetIconForObject(GO, NoteIcon.icon);
        NoteUtility NoteComponent = GO.AddComponent(typeof(NoteUtility)) as NoteUtility;
        GO.tag = "EditorOnly";
    }
}

[CustomEditor(typeof(NoteUtility))]
public class NoteComponentCustomEditor : Editor
{
    private static readonly string dontInclude = new string("m_Script");
    
    public override void OnInspectorGUI()
    {
        serializedObject.Update();
        DrawPropertiesExcluding(serializedObject, dontInclude);
        EditorGUILayout.PropertyField(this.serializedObject.FindProperty("NoteText"), GUIContent.none);
        serializedObject.ApplyModifiedProperties();
    }
}

[InitializeOnLoad]
public class NoteIcon
{
    static MonoScript script = MonoScript.FromMonoBehaviour((MonoBehaviour)GameObject.FindObjectOfType(typeof(NoteUtility)));
    public static Texture2D icon;

    static NoteIcon()
    {
        AssemblyReloadEvents.afterAssemblyReload += OnAfterAssemblyReload;
        HierarchyNoteIcon();
    }

    private static void OnAfterAssemblyReload()
    {
        EditorApplication.delayCall += () =>
        {
            NoteIcon.icon = AssetDatabase.LoadAssetAtPath<Texture2D>(Path.GetDirectoryName(AssetDatabase.GetAssetPath(script)) + "\\Ico_Note.png");

            if (icon)
            {
                EditorGUIUtility.SetIconForObject(script, icon);
            } 
            else
            {
                Debug.Log("<color=#ffa500ff>Ico_Note.png is missing, it should be placed in the same folder as NoteUtility script.</color> \n>>>\nIcon is not always displayed in the <color=#008000ff><b>Project window</b></color>. However, if Note object in scene changed it's icon properly that indicate that everything is working fine. Icon will be shown evetyally.\n>>>");
            }
        };
    }

    static void HierarchyNoteIcon()
    {
        EditorApplication.hierarchyWindowItemOnGUI += (int instanceID, Rect selectionRect) =>
        {
            GameObject GO = EditorUtility.InstanceIDToObject(instanceID) as GameObject;

            if (GO != null && GO.GetComponent<NoteUtility>() != null)
                GUI.DrawTexture(new Rect(selectionRect.xMin, selectionRect.yMin, 16, 16), icon);
        };
    }
}